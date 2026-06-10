import 'package:get_it/get_it.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_media_service.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_rest_service.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/controllers/assistant_controller.dart';

void initVoiceAssistantDependencies(GetIt sl) {
  // Service (Singleton, reused across sessions)
  sl.registerLazySingleton<AssistantRestService>(
    () => AssistantRestService(),
  );

  sl.registerLazySingleton<AssistantMediaService>(
    () => AssistantMediaService(),
  );

  // Controller (Factory, new instance per screen)
  sl.registerFactory<AssistantController>(
    () => AssistantController(
      restService: sl(),
      mediaService: sl(),
      ttsService: sl(),
    ),
  );
}
