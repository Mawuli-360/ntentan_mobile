import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/widgets/voice_message_bubble.dart';

class VoiceChatMessage {
  final bool isUser;
  final String text;
  VoiceChatMessage(this.isUser, this.text);
}

class VoiceChatHistory extends StatelessWidget {
  final List<VoiceChatMessage> messages;

  const VoiceChatHistory({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.space16),
      itemCount: messages.length,
      itemBuilder: (_, i) {
        final msg = messages[i];
        return VoiceMessageBubble(isUser: msg.isUser, text: msg.text);
      },
    );
  }
}
