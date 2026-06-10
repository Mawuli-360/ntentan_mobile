import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/services/notification_service.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';
import 'package:ntentan/features/settings/domain/repositories/medication_repository.dart';
import 'package:ntentan/features/settings/presentation/controllers/medication_controller.dart';
import 'package:ntentan/features/settings/presentation/state/medication_state.dart';

class MockMedicationRepository extends Mock implements MedicationRepository {}
class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MedicationController controller;
  late MockMedicationRepository mockRepository;
  late MockNotificationService mockNotificationService;

  setUpAll(() {
    registerFallbackValue(const Medication(id: 'fallback', name: '', dosage: '', instruction: '', timeSlots: []));
  });

  setUp(() {
    mockRepository = MockMedicationRepository();
    mockNotificationService = MockNotificationService();

    when(() => mockRepository.watchMedications(any()))
        .thenAnswer((_) => Stream.value(const Right(<Medication>[])));

    controller = MedicationController(mockRepository, mockNotificationService);
  });

  group('SessionLifecycleHandler', () {
    test('onSessionStarted should start watching medications', () async {
      final streamController = StreamController<Either<Failure, List<Medication>>>();
      when(() => mockRepository.watchMedications('user123'))
          .thenAnswer((_) => streamController.stream);

      await controller.onSessionStarted('user123');

      expect(controller.state.isLoading, true);

      final meds = [const Medication(id: 'med1', name: 'Aspirin', dosage: '10mg', instruction: 'Take with water', timeSlots: [])];
      streamController.add(right(meds));
      
      await Future.delayed(Duration.zero); // allow stream to process

      expect(controller.state.isLoading, false);
      expect(controller.state.medications, meds);

      await streamController.close();
    });

    test('onSessionEnded should reset state and cancel subscription', () async {
      await controller.onSessionStarted('user123');
      expect(controller.state.isLoading, false); // From the default stream in setUp

      await controller.onSessionEnded();

      expect(controller.state, const MedicationState.initial());
    });
  });

  group('CRUD operations', () {
    const tUserId = 'user123';
    final tMed = const Medication(id: 'med1', name: 'Aspirin', dosage: '10mg', instruction: 'Take with water', timeSlots: []);

    setUp(() async {
      when(() => mockRepository.saveMedication(any(), any())).thenAnswer((_) async => const Right(unit));
      when(() => mockRepository.updateMedication(any(), any())).thenAnswer((_) async => const Right(unit));
      when(() => mockRepository.deleteMedication(any(), any())).thenAnswer((_) async => const Right(unit));
      when(() => mockNotificationService.syncReminders()).thenAnswer((_) async {});

      await controller.onSessionStarted(tUserId);
      await Future.delayed(Duration.zero);
    });

    test('addMedication should add to state and sync reminders', () async {
      await controller.addMedication(tMed);

      expect(controller.state.medications.length, 1);
      expect(controller.state.medications.first.name, 'Aspirin');
      verify(() => mockRepository.saveMedication(tUserId, any())).called(1);
      verify(() => mockNotificationService.syncReminders()).called(1);
    });

    test('updateMedication should update state and sync reminders', () async {
      await controller.addMedication(tMed); // adds it first
      
      final updatedMed = tMed.copyWith(name: 'Ibuprofen');
      await controller.updateMedication(updatedMed);

      expect(controller.state.medications.length, 1);
      expect(controller.state.medications.first.name, 'Ibuprofen');
      verify(() => mockRepository.updateMedication(tUserId, any())).called(1);
      // Called twice: once for add, once for update
      verify(() => mockNotificationService.syncReminders()).called(2);
    });

    test('deleteMedication should remove from state and sync reminders', () async {
      await controller.addMedication(tMed);

      await controller.deleteMedication('med1');

      expect(controller.state.medications.isEmpty, true);
      verify(() => mockRepository.deleteMedication(tUserId, 'med1')).called(1);
      verify(() => mockNotificationService.syncReminders()).called(2); // add + delete
    });
    
    test('toggleSlotCompletion should update completed slots', () async {
      final slot = MedTimeSlot.morning;
      final medWithSlot = tMed.copyWith(timeSlots: [slot]);
      
      await controller.addMedication(medWithSlot);
      
      // Toggle ON
      await controller.toggleSlotCompletion('med1', slot);
      expect(controller.state.medications.first.completedSlots.containsKey(slot.name), true);
      
      // Toggle OFF
      await controller.toggleSlotCompletion('med1', slot);
      expect(controller.state.medications.first.completedSlots.containsKey(slot.name), false);
    });
  });
}
