import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class AssistantTextInput extends StatefulWidget {
  final ValueChanged<String> onSend;
  
  const AssistantTextInput({super.key, required this.onSend});

  @override
  State<AssistantTextInput> createState() => _AssistantTextInputState();
}

class _AssistantTextInputState extends State<AssistantTextInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
      Navigator.pop(context); // Close bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    // Requires padding for keyboard
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.space16,
        right: AppSizes.space16,
        top: AppSizes.space16,
        bottom: AppSizes.space16 + bottomPadding,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLarge)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.space16, 
                      vertical: AppSizes.space12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.space12),
              CircleAvatar(
                backgroundColor: AppColors.vi,
                radius: 24,
                child: IconButton(
                  icon: const Icon(Icons.send_rounded, color: AppColors.bg),
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
