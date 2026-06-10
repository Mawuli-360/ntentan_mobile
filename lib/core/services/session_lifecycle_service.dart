import 'dart:collection';

import 'package:ntentan/core/constants/logger.dart';


/// Abstract contract every feature module must implement to participate in
/// the session lifecycle.
abstract class SessionLifecycleHandler {
  /// Called when a user session starts (sign-in / auth-state-becomes-non-null).
  /// [userId] is the Firebase UID of the authenticated user.
  Future<void> onSessionStarted(String userId);

  /// Called when a user session ends (sign-out / auth-state-becomes-null).
  Future<void> onSessionEnded();

  /// Called when a user's account is permanently deleted from the system.
  /// Use this to purge all user-specific data from Firestore and local DB.
  Future<void> onAccountDeleted(String userId);
}

/// Coordinates ordered, concurrent execution of [SessionLifecycleHandler]s.
///
/// Handlers are grouped by [priority] (lower number = runs first).
/// Within each priority group, handlers are run concurrently via [Future.wait].
/// Groups themselves are run sequentially.
///
/// - [startSession] runs groups in ascending priority order.
/// - [endSession] and [deleteAccount] run groups in descending priority order.
class SessionLifecycleService {
  final SplayTreeMap<int, List<SessionLifecycleHandler>> _handlers =
      SplayTreeMap();

  /// Registers a [handler] at the given [priority].
  /// Lower [priority] values run first.
  void register(SessionLifecycleHandler handler, {int priority = 50}) {
    _handlers.putIfAbsent(priority, () => []).add(handler);
  }

  /// Runs all handlers' [onSessionStarted] in ascending priority order.
  Future<void> startSession(String userId) async {
    AppLogger.i(
      'SessionLifecycleService: starting session for user $userId',
    );
    for (final entry in _handlers.entries) {
      AppLogger.i(
        'SessionLifecycleService: running onSessionStarted (priority ${entry.key})',
      );
      await Future.wait(
        entry.value.map((h) => h.onSessionStarted(userId)),
      );
    }
  }

  /// Runs all handlers' [onSessionEnded] in descending priority order.
  Future<void> endSession() async {
    AppLogger.i('SessionLifecycleService: ending session');
    for (final entry in _handlers.entries.toList().reversed) {
      AppLogger.i(
        'SessionLifecycleService: running onSessionEnded (priority ${entry.key})',
      );
      await Future.wait(
        entry.value.map((h) => h.onSessionEnded()),
      );
    }
  }

  /// Runs all handlers' [onAccountDeleted] in descending priority order.
  Future<void> deleteAccount(String userId) async {
    AppLogger.i('SessionLifecycleService: clearing account data for $userId');
    for (final entry in _handlers.entries.toList().reversed) {
      AppLogger.i(
        'SessionLifecycleService: running onAccountDeleted (priority ${entry.key})',
      );
      await Future.wait(
        entry.value.map((h) => h.onAccountDeleted(userId)),
      );
    }
  }
}
