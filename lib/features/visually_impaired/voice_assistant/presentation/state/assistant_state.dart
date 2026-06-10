import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/widgets/voice_chat_history.dart';

part 'assistant_state.freezed.dart';

enum AssistantPhase {
  idle,
  listening,
  sending,
  thinking,
  error,
}

@freezed
sealed class AssistantState with _$AssistantState {
  const AssistantState._();

  const factory AssistantState.idle({
    @Default([]) List<VoiceChatMessage> messages,
    @Default('english') String selectedLanguage,
  }) = AssistantIdle;

  const factory AssistantState.listening({
    @Default([]) List<VoiceChatMessage> messages,
    @Default('english') String selectedLanguage,
  }) = AssistantListening;

  const factory AssistantState.sending({
    @Default([]) List<VoiceChatMessage> messages,
    @Default('english') String selectedLanguage,
  }) = AssistantSending;

  const factory AssistantState.thinking({
    @Default([]) List<VoiceChatMessage> messages,
    @Default('english') String selectedLanguage,
  }) = AssistantThinking;

  const factory AssistantState.error({
    @Default([]) List<VoiceChatMessage> messages,
    @Default('english') String selectedLanguage,
    required String errorMessage,
  }) = AssistantError;

  // UI Backward Compatibility Getters
  AssistantPhase get phase => switch (this) {
        AssistantIdle() => AssistantPhase.idle,
        AssistantListening() => AssistantPhase.listening,
        AssistantSending() => AssistantPhase.sending,
        AssistantThinking() => AssistantPhase.thinking,
        AssistantError() => AssistantPhase.error,
      };


  String? get errorMessage => switch (this) {
        AssistantError(errorMessage: final e) => e,
        _ => null,
      };
}
