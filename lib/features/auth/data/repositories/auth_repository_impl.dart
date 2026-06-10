import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/core/utils/storage/secure_storage.dart';
import 'package:ntentan/core/utils/storage/shared_prefs_storage.dart';
import 'package:ntentan/features/auth/data/datasources/profile_local_data_source.dart';
import 'package:ntentan/features/auth/domain/repositories/auth_repository.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/firebase_options.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _authClient;
  final SecureStorage _secureStorage;
  final SharedPrefsStorage _sharedPrefsStorage;
  final ProfileLocalDataSource _profileLocalDataSource;
  final SessionLifecycleService _lifecycleService;
  bool _isInitialized = false;

  AuthRepositoryImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore firestore, // Kept for interface compatibility or future use if needed, but removing internal use
    required SecureStorage secureStorage,
    required SharedPrefsStorage sharedPrefsStorage,
    required ProfileLocalDataSource profileLocalDataSource,
    required SessionLifecycleService lifecycleService,
  })  : _authClient = authClient,
        _secureStorage = secureStorage,
        _sharedPrefsStorage = sharedPrefsStorage,
        _profileLocalDataSource = profileLocalDataSource,
        _lifecycleService = lifecycleService;

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;

    String? clientId = Platform.isIOS
        ? DefaultFirebaseOptions.currentPlatform.iosClientId
        : DefaultFirebaseOptions.currentPlatform.androidClientId;

    if (clientId == null) {
      throw Exception("Client ID is null");
    }
    // According to GoogleSignIn 7.x Android docs:
    // If using google-services.json, no identifiers need to be provided in Dart on Android.
    // The native SDK will auto-detect the Web Client ID for the idToken.
    await gsi.GoogleSignIn.instance.initialize(
      clientId: clientId,
    );
    _isInitialized = true;
  }

  @override
  Stream<User?> get authStateChanges => _authClient.authStateChanges();

  @override
  User? get currentUser => _authClient.currentUser;

  @override
  FutureEither<User> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCreds = await _authClient.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCreds.user == null) {
        return left(
            const Failure.unauthorized(message: 'Failed to register account'));
      }

      return right(userCreds.user!);
    } on FirebaseAuthException catch (e) {
      return left(
          Failure.unauthorized(message: e.message ?? 'Registration failed'));
    } catch (e) {
      return left(
          const Failure.unexpected(message: 'An unexpected error occurred'));
    }
  }

  @override
  FutureEither<User> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        return left(const Failure.unauthorized(message: 'Failed to sign in'));
      }
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return left(Failure.unauthorized(message: e.message ?? 'Sign-in failed'));
    } catch (e) {
      return left(
          const Failure.unexpected(message: 'An unexpected error occurred'));
    }
  }

  @override
  FutureEither<User> signInWithGoogle() async {
    try {
      await _ensureInitialized();
      await gsi.GoogleSignIn.instance.signOut();

      // ignore: unnecessary_nullable_for_final_variable_declarations
      final gsi.GoogleSignInAccount? response =
          await gsi.GoogleSignIn.instance.authenticate();

      if (response == null) {
        return left(
            const Failure.unauthorized(message: 'Google sign-in cancelled'));
      }

      final gsi.GoogleSignInAuthentication auth = response.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
      );

      final userCreds = await _authClient.signInWithCredential(credential);

      if (userCreds.user == null) {
        return left(const Failure.unauthorized(
            message: 'Failed to authenticate account'));
      }

      return right(userCreds.user!);
    } on FirebaseAuthException catch (e) {
      return left(
          Failure.unauthorized(message: e.message ?? 'Google sign-in failed'));
    } catch (e) {
      return left(Failure.unexpected(message: 'Sign-in failed: $e'));
    }
  }

  @override
  FutureVoid signOut() async {
    try {
      await _authClient.signOut();
      await gsi.GoogleSignIn.instance.signOut().catchError((_) {});

      // Clear all local user data
      await Future.wait([
        _secureStorage.clearAll(),
        _profileLocalDataSource.clearProfile(),
      ]);
      await _sharedPrefsStorage.setOnboardingCompleted(false);

      return const Right(unit);
    } catch (e) {
      return left(const Failure.unexpected(message: 'Sign out failed'));
    }
  }

  @override
  FutureVoid deleteAccount({String? password}) async {
    final currentUser = _authClient.currentUser;
    if (currentUser == null) {
      return left(const Failure.unauthorized(
          message: 'User not found or not logged in'));
    }

    try {
      await _reauthenticateUser(currentUser, password: password);
      
      // Trigger global account deletion cleanup across all modules
      // (This deletes Firestore data/subcollections and local DB caches)
      await _lifecycleService.deleteAccount(currentUser.uid);

      await currentUser.delete();

      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return left(const Failure.unauthorized(
            message: 'Incorrect password provided.'));
      }
      if (e.code == 'requires-recent-login') {
        return left(const Failure.unauthorized(
            message:
                'Sensitive operation. Please sign out and sign back in before deleting.'));
      }
      return left(Failure.unauthorized(
          message: 'Failed to re-authenticate: ${e.message}'));
    } catch (e) {
      return left(Failure.unexpected(message: 'Failed to delete account: $e'));
    }
  }

  Future<void> _reauthenticateUser(User user, {String? password}) async {
    final providerId = user.providerData.firstOrNull?.providerId;

    switch (providerId) {
      case 'password':
        if (password == null || password.isEmpty) {
          throw Exception('Password is required for account deletion.');
        }
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        break;
      case 'google.com':
        await _ensureInitialized();
        final googleUser = await gsi.GoogleSignIn.instance
                .attemptLightweightAuthentication() ??
            await gsi.GoogleSignIn.instance.authenticate();

        final googleAuth = googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        await user.reauthenticateWithCredential(credential);
        break;
      default:
        throw Exception('Unknown authentication method.');
    }
  }
}
