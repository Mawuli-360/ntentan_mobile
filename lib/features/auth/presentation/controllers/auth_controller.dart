import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ntentan/features/auth/domain/repositories/auth_repository.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/features/auth/presentation/state/auth_state.dart';
import 'package:ntentan/features/auth/presentation/mixins/auth_action_mixin.dart';

/// Controller for managing Authentication state and business logic.
class AuthController extends ChangeNotifier with AuthActionMixin {
  final AuthRepository _authRepository;
  final SessionLifecycleService _lifecycleService;

  AuthState _state = const AuthState.initial();

  AuthController(this._authRepository, this._lifecycleService);

  // ── Getters ──
  AuthState get state => _state;
  User? get currentUser => _authRepository.currentUser;

  // ── State Mutator ──
  @override
  void updateState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  // ── Actions ──

  /// Sign in with Google.
  Future<bool> signInWithGoogle() => executeAuthAction(
        () => _authRepository.signInWithGoogle(),
        onSuccess: () async {
          if (currentUser != null) {
            await _lifecycleService.startSession(currentUser!.uid);
          }
        },
      );

  /// Sign in with Email and Password.
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) =>
      executeAuthAction(
        () => _authRepository.signInWithEmailAndPassword(email, password),
        onSuccess: () async {
          if (currentUser != null) {
            await _lifecycleService.startSession(currentUser!.uid);
          }
        },
      );

  /// Register a new account with Email and Password.
  Future<bool> registerWithEmail({
    required String email,
    required String password,
  }) =>
      executeAuthAction(
        () => _authRepository.registerWithEmailAndPassword(email, password),
        onSuccess: () async {
          if (currentUser != null) {
            await _lifecycleService.startSession(currentUser!.uid);
          }
        },
      );

  /// Sign out from all providers.
  Future<void> signOut() async {
    await _lifecycleService.endSession();
    await _authRepository.signOut();
  }

  /// Delete the user's account permanently.
  Future<bool> deleteAccount({String? password}) => executeAuthAction(
        () => _authRepository.deleteAccount(password: password),
        onSuccess: () async {
          await _lifecycleService.endSession();
        },
      );

  /// Clear any existing error messages.
  void clearError() {
    if (_state is AuthStateError) {
      updateState(const AuthState.initial());
    }
  }
}
