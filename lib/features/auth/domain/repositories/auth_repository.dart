import 'package:firebase_auth/firebase_auth.dart';
import 'package:ntentan/core/utils/custom_types.dart';

abstract class AuthRepository {
  /// Stream of the user's authentication state.
  Stream<User?> get authStateChanges;

  /// Returns the currently signed-in user, or null if unauthenticated.
  User? get currentUser;

  /// Register a new account using Email and Password.
  FutureEither<User> registerWithEmailAndPassword(String email, String password);

  /// Sign in to an existing account using Email and Password.
  FutureEither<User> signInWithEmailAndPassword(String email, String password);

  /// Authenticate using Google Sign-In.
  FutureEither<User> signInWithGoogle();

  /// Sign out clearly across all providers (Firebase + Google).
  FutureVoid signOut();

  /// Delete the user's account permanently. Requires re-authentication.
  /// If the current provider is password, the [password] must be provided.
  FutureVoid deleteAccount({String? password});
}
