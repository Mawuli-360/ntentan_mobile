import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/features/auth/presentation/state/auth_state.dart';

/// A mixin that abstracts away common loading, error, and success state
/// transitions for authentication actions.
mixin AuthActionMixin {
  /// The class using this mixin must implement how state is updated.
  void updateState(AuthState newState);

  /// Executes an authentication action, managing the loading and error states automatically.
  Future<bool> executeAuthAction<T>(
    FutureEither<T> Function() action, {
    Future<void> Function()? onSuccess,
  }) async {
    updateState(const AuthState.loading());
    final result = await action();

    return result.fold(
      (failure) {
        updateState(AuthState.error(failure.message));
        return false;
      },
      (_) async {
        updateState(const AuthState.initial());
        if (onSuccess != null) {
          await onSuccess();
        }
        return true;
      },
    );
  }
}
