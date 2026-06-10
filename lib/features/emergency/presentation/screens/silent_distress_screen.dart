import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/app_header.dart';

import 'package:ntentan/features/emergency/presentation/widgets/silent_distress_main_view.dart';
import 'package:ntentan/features/emergency/presentation/widgets/silent_distress_helper_view.dart';

/// Silent Distress Mode — Phase 5
/// "Show Helper" card with multi-language text.
/// For DM users who cannot speak — shows a helper card to bystanders.
class SilentDistressScreen extends StatefulWidget {
  const SilentDistressScreen({super.key});
  @override
  State<SilentDistressScreen> createState() => _SilentDistressScreenState();
}

class _SilentDistressScreenState extends State<SilentDistressScreen> {
  final ValueNotifier<bool> _showHelperCard = ValueNotifier(false);
  final ValueNotifier<String> _helperLanguage = ValueNotifier('English');

  final _helperTexts = {
    'English':
        'I need help. I am deaf and cannot speak.\nPlease call emergency services.\nMy name and medical information are on this phone.',
    'French':
        "J'ai besoin d'aide. Je suis sourd(e) et ne peux pas parler.\nVeuillez appeler les services d'urgence.\nMon nom et mes informations médicales sont sur ce téléphone.",
    'Twi':
        'Mehia mmoa. Mete sɔ na mentumi nkasa.\nMesrɛ wo frɛ emergency services.\nMe din ne me ho nsɛm wɔ saa phone yi so.',
    'Arabic':
        'أحتاج مساعدة. أنا أصم ولا أستطيع الكلام.\nالرجاء الاتصال بخدمات الطوارئ.\nاسمي ومعلوماتي الطبية موجودة على هذا الهاتف.',
  };

  @override
  void dispose() {
    _showHelperCard.dispose();
    _helperLanguage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppHeader(
        title: 'Silent Distress',
        backgroundColor: AppColors.vi.withValues(alpha: 0.1),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.space24),
          child: ValueListenableBuilder<bool>(
            valueListenable: _showHelperCard,
            builder: (_, showing, __) {
              if (showing) {
                return ValueListenableBuilder<String>(
                  valueListenable: _helperLanguage,
                  builder: (_, lang, __) {
                    return SilentDistressHelperView(
                      helperTexts: _helperTexts,
                      selectedLanguage: lang,
                      onLanguageSelected: (l) => _helperLanguage.value = l,
                      onBack: () => _showHelperCard.value = false,
                    );
                  },
                );
              }
              return SilentDistressMainView(
                onShowHelper: () => _showHelperCard.value = true,
                onCancel: () => Navigator.of(context).pop(),
              );
            },
          ),
        ),
      ),
    );
  }
}
