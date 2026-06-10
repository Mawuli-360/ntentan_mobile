import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = AuthStateInitial;
  const factory AuthState.loading() = AuthStateLoading;
  const factory AuthState.error(String message) = AuthStateError;

  bool get isLoading => this is AuthStateLoading;

  String? get errorMessage => switch (this) {
        AuthStateError(message: final m) => m,
        _ => null,
      };
}
