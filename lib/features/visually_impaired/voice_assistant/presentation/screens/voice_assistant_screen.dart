import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/app_header.dart';
import 'package:ntentan/shared/widgets/feature_tag.dart';
import 'package:ntentan/app/injection_container.dart';

import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/controllers/assistant_controller.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/state/assistant_state.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/widgets/assistant_status_banner.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/widgets/assistant_text_input.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/widgets/voice_chat_history.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/widgets/voice_mic_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

/// AI Voice Health Assistant — VI Feature
class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  late final AssistantController _controller;

  @override
  void initState() {
    super.initState();
    _controller = sl<AssistantController>();
    _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showTextInputSheet() {
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (context) {
        return [
          WoltModalSheetPage(
            hasTopBarLayer: false,
            isTopBarLayerAlwaysVisible: false,
            child: AssistantTextInput(
              onSend: (text) {
                _controller.sendText(text);
              },
            ),
          ),
        ];
      },
    );
  }

  void _onMicTapped() {
    if (_controller.state.phase == AssistantPhase.listening) {
      _controller.stopRecording();
    } else {
      _controller.startRecording();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final state = _controller.state;
        
        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: const AppHeader(
            title: 'Voice Assistant',
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: FeatureTag(label: 'AI Powered', type: TrackType.ai),
              ),
            ],
          ),
          body: Column(
            children: [
              AssistantStatusBanner(
                phase: state.phase,
                errorMessage: state.errorMessage,
              ),

              // Feature tags & Language Selection
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.space16, vertical: AppSizes.space8),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    const FeatureTag(label: 'Connected', type: TrackType.vi),
                    _buildLanguageSelector(state),
                  ],
                ),
              ),

              // Chat history
              Expanded(
                child: VoiceChatHistory(messages: state.messages),
              ),

              // Fallback keyboard button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.space16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _showTextInputSheet,
                      icon: const Icon(Icons.keyboard_rounded, size: 20),
                      label: const Text(
                        'Type instead',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.space8),

              // Mic button
              Padding(
                padding: const EdgeInsets.all(AppSizes.space24),
                child: VoiceMicButton(
                  isRecording: state.phase == AssistantPhase.listening,
                  onTap: _onMicTapped,
                  recorderController: _controller.recorderController,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageSelector(AssistantState state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLangChip('English', 'english', state.selectedLanguage),
          _buildLangChip('Twi', 'twi', state.selectedLanguage),
        ],
      ),
    );
  }

  Widget _buildLangChip(String label, String value, String selectedValue) {
    final isSelected = value == selectedValue;
    return GestureDetector(
      onTap: () => _controller.setLanguage(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.vi.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.vi : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
