class EnvKeys {
  const EnvKeys._();

  static const String baseUrl = 'API_BASE_URL';
  static const String webSocketUrl = 'WS_BASE_URL';
}

class StorageKeys {
  const StorageKeys._();

  static const String onboardingCompletedKey = 'onboarding_completed';
  static const String termsAcceptedKey = 'terms_accepted';
  static const String authTokenKey = 'auth_token';
  static const String cachedUserKey = 'cached_user';
  static const String profileKey = 'user_profile_data';
  static const String fcmTokenKey = 'fcm_token';
}
