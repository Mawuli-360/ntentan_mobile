import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/core/services/notification_service.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';
import 'package:ntentan/features/settings/domain/repositories/medication_repository.dart';
import 'package:ntentan/features/settings/presentation/state/medication_state.dart';

/// Manages medication state and delegates persistence to [MedicationRepository].
class MedicationController extends ChangeNotifier
    implements SessionLifecycleHandler {
  final MedicationRepository _repository;
  final NotificationService _notificationService;

  MedicationState _state = const MedicationState.initial();
  MedicationState get state => _state;

  /// The authenticated user's UID, set when a session starts.
  String? _uid;

  StreamSubscription<Either<Failure, List<Medication>>>? _subscription;

  MedicationController(this._repository, this._notificationService);

  // ── State Mutators ────────────────────────────────────────────────────────────

  void updateState(MedicationState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setLoading() => updateState(MedicationState.loading(
        medications: state.medications,
      ));

  void _setLoaded(List<Medication> meds) => updateState(MedicationState.loaded(
        medications: meds,
      ));

  void _setError(String msg) => updateState(MedicationState.error(
        medications: state.medications,
        message: msg,
      ));

  // ── Session ───────────────────────────────────────────────────────────────────

  @override
  Future<void> onSessionStarted(String userId) async {
    _uid = userId;

    _setLoading();

    _subscription?.cancel();
    _subscription = _repository.watchMedications(userId).listen((result) {
      result.fold(
        (failure) {
          AppLogger.e('MedicationController watch error: ${failure.message}');
          _setError(failure.message);
        },
        (meds) {
          _setLoaded(meds);
        },
      );
    });
  }

  @override
  Future<void> onSessionEnded() async {
    _uid = null;
    _subscription?.cancel();
    _subscription = null;
    updateState(const MedicationState.initial());
  }

  @override
  Future<void> onAccountDeleted(String userId) async {
    await onSessionEnded();
  }

  // ── Load ──────────────────────────────────────────────────────────────────────

  // (Data is now loaded automatically via the real-time stream subscription)

  // ── Add ───────────────────────────────────────────────────────────────────────

  Future<void> addMedication(Medication med) async {
    final medWithTimestamp = med.copyWith(updatedAt: DateTime.now());
    _setLoaded([...state.medications, medWithTimestamp]);

    if (_uid != null) {
      final result = await _repository.saveMedication(_uid!, medWithTimestamp);
      result.fold(
        (f) => AppLogger.e('Failed to save medication: ${f.message}'),
        (_) => _notificationService.syncReminders(),
      );
    }
  }

  Future<void> addMedications(List<Medication> meds) async {
    final now = DateTime.now();
    final medsWithTimestamps =
        meds.map((m) => m.copyWith(updatedAt: now)).toList();
    _setLoaded([...state.medications, ...medsWithTimestamps]);

    if (_uid != null) {
      for (final med in medsWithTimestamps) {
        final result = await _repository.saveMedication(_uid!, med);
        result.fold(
          (f) =>
              AppLogger.e('Failed to save medication ${med.id}: ${f.message}'),
          (_) {},
        );
      }
      _notificationService.syncReminders();
    }
  }

  // ── Update ────────────────────────────────────────────────────────────────────

  Future<void> updateMedication(Medication updated) async {
    // Optimistic update
    final idx = state.medications.indexWhere((m) => m.id == updated.id);
    if (idx == -1) return;

    final medWithTimestamp = updated.copyWith(updatedAt: DateTime.now());
    final updatedList = [...state.medications];
    updatedList[idx] = medWithTimestamp;
    _setLoaded(updatedList);

    if (_uid != null) {
      final result =
          await _repository.updateMedication(_uid!, medWithTimestamp);
      result.fold(
        (f) => AppLogger.e('Failed to update medication: ${f.message}'),
        (_) => _notificationService.syncReminders(),
      );
    }
  }

  // ── Toggle Slot Completion ──────────────────────────────────────────────────

  Future<void> toggleSlotCompletion(String id, MedTimeSlot slot) async {
    final med = state.medications.firstWhere(
      (m) => m.id == id,
      orElse: () => throw StateError('Medication $id not found'),
    );

    final completed = Map<String, DateTime>.from(med.completedSlots);
    if (completed.containsKey(slot.name)) {
      completed.remove(slot.name);
    } else {
      completed[slot.name] = DateTime.now();
    }

    await updateMedication(med.copyWith(completedSlots: completed));
  }

  // ── Delete ────────────────────────────────────────────────────────────────────

  Future<void> deleteMedication(String id) async {
    // Optimistic remove
    final updated = state.medications.where((m) => m.id != id).toList();
    _setLoaded(updated);

    if (_uid != null) {
      final result = await _repository.deleteMedication(_uid!, id);
      result.fold(
        (f) => AppLogger.e('Failed to delete medication: ${f.message}'),
        (_) => _notificationService.syncReminders(),
      );
    }
  }

  // ── Convenience ───────────────────────────────────────────────────────────────

  void setMedications(List<Medication> meds) {
    _setLoaded(meds);
  }
}
