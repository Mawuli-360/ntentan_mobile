import 'package:flutter/material.dart';

import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/features/dashboard/presentation/state/dashboard_state.dart';

/// Dashboard controller — manages dashboard state via [DashboardState],
/// adapts UI based on disability profile.
class DashboardController extends ChangeNotifier
    implements SessionLifecycleHandler {
  DashboardState _state = const DashboardState();

  DashboardController();

  // ── Getters ──
  DashboardState get state => _state;

  // ── State Mutator ──
  void updateState(DashboardState newState) {
    _state = newState;
    notifyListeners();
  }

  // ── Actions ──

  void setNavIndex(int index) {
    if (index < 0 || index > 2) return;
    updateState(state.copyWith(selectedNavIndex: index));
  }

  // ── SessionLifecycleHandler ──

  @override
  Future<void> onSessionStarted(String userId) async {
    updateState(state.copyWith(
      selectedNavIndex: 0,
    ));
  }

  @override
  Future<void> onSessionEnded() async {
    updateState(const DashboardState());
  }

  @override
  Future<void> onAccountDeleted(String userId) async {
    await onSessionEnded();
  }
}
