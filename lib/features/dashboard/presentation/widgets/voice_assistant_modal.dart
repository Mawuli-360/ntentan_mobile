import 'dart:async';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:get_it/get_it.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/controllers/assistant_controller.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/state/assistant_state.dart';
import 'package:ntentan/shared/widgets/pulsing_wave_animation.dart';

class VoiceAssistantModal extends StatefulWidget {

  const VoiceAssistantModal({super.key});

  @override
  State<VoiceAssistantModal> createState() => _VoiceAssistantModalState();
}

class _VoiceAssistantModalState extends State<VoiceAssistantModal> {
  late final AssistantController _controller;
  int _tapCount = 0;
  Timer? _tapTimer;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I<AssistantController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final onboarding = context.read<ProfileController>();
      _controller.setLanguage(
          (onboarding.state.profile?.selectedLanguage ?? "English"));
      _initAndStart();
    });
  }

  Future<void> _initAndStart() async {
    await _controller.init();
    await _controller.startRecording();
  }

  @override
  void dispose() {
    _tapTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _tapCount++;
    if (_tapCount == 3) {
      _tapTimer?.cancel();
      _tapCount = 0;
      Navigator.of(context).pop();
    } else {
      _tapTimer?.cancel();
      _tapTimer = Timer(const Duration(milliseconds: 500), () {
        _tapCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      onLongPress: () {
        final phase = _controller.state.phase;
        if (phase == AssistantPhase.listening) {
          _controller.stopRecording();
        } else if (phase == AssistantPhase.idle ||
            phase == AssistantPhase.error) {
          _controller.startRecording();
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(32)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.65),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(32)),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListenableBuilder(
                    listenable: _controller,
                    builder: (context, _) {
                      final phase = _controller.state.phase;

                      String statusText = 'LISTENING...';
                      Widget middleContent = SizedBox(
                        height: 200,
                        width: 200,
                        child: Lottie.asset(
                          'assets/animations/listen.json',
                          fit: BoxFit.contain,
                        ),
                      );

                      if (phase == AssistantPhase.thinking ||
                          phase == AssistantPhase.sending) {
                        statusText = 'PROCESSING...';
                        middleContent = SizedBox(
                          height: 200,
                          width: 200,
                          child: Lottie.asset(
                            'assets/animations/listen.json',
                            fit: BoxFit.contain,
                          ),
                        );
                      } else if (phase == AssistantPhase.idle &&
                          _controller.state.messages.isNotEmpty) {
                        statusText = 'RESPONSE RECEIVED';
                        final lastMsg = _controller.state.messages.last;
                        middleContent = Container(
                          height: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SingleChildScrollView(
                            child: Text(
                              lastMsg.text,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'NotoSans'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else if (phase == AssistantPhase.error) {
                        statusText = 'ERROR';
                        middleContent = Container(
                          height: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Center(
                            child: Text(
                              _controller.state.errorMessage ??
                                  'Something went wrong.',
                              style: const TextStyle(
                                  color: Colors.redAccent, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else if (phase == AssistantPhase.idle &&
                          _controller.state.messages.isEmpty) {
                        statusText = 'READY';
                        middleContent = const SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(
                              child: Icon(Icons.mic,
                                  color: Colors.white, size: 48)),
                        );
                      }

                      // Apply pulsing animation if listening, thinking, or sending (which includes speaking)
                      final isAnimating = phase == AssistantPhase.listening ||
                          phase == AssistantPhase.thinking ||
                          phase == AssistantPhase.sending;

                      middleContent = PulsingWaveAnimation(
                        isSpeakingOrListening: isAnimating,
                        child: middleContent,
                      );

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const Text(
                            'How can I help you?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 40),
                          middleContent,
                          const SizedBox(height: 40),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.0,
                            ),
                          ),
                          if (phase == AssistantPhase.listening) ...[
                            const SizedBox(height: 16),
                            Text(
                              'Long press here to send',
                              style: TextStyle(
                                color: AppColors.vi.withValues(alpha: 0.8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          const SizedBox(height: 32),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
