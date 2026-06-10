import 'package:get_it/get_it.dart';
import 'package:ntentan/core/services/accessibility/accessibility_announcement_service.dart';
import 'package:ntentan/core/services/accessibility/earcon_service.dart';
import 'package:ntentan/core/services/accessibility/haptic_service.dart';

void initAccessibilityServices(GetIt sl) {
  sl.registerLazySingleton<HapticService>(() => HapticService());
  sl.registerLazySingleton<AccessibilityAnnouncementService>(() => AccessibilityAnnouncementService());
  sl.registerLazySingleton<EarconService>(() => EarconService());
}

Future<void> initAccessibilityAsync(GetIt sl) async {
  await sl<HapticService>().init();
}
