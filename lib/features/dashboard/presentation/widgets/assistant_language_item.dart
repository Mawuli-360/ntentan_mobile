import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/haptics.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';
import 'package:ntentan/shared/widgets/settings_item.dart';

class AssistantLanguageItem extends StatelessWidget {
  const AssistantLanguageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, profileController, _) {
        final isEnglish =
            (profileController.state.profile?.selectedLanguage ?? "English")
                    .toLowerCase() ==
                'english';

        return SettingsItem(
          icon: Iconsax.language_circle,
          iconColor: Colors.deepPurpleAccent,
          label: 'Assistant Language',
          subtitle: 'Spoken language for AI',
          disableRipple: true,
          onTap: () {
            final newLang = isEnglish ? 'twi' : 'english';
            profileController.updateProfile(
              (profileController.state.profile ?? const UserEntity())
                  .copyWith(selectedLanguage: newLang),
            );
            AppHaptics.light();
          },
          trailing: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!isEnglish) {
                      profileController.updateProfile(
                        (profileController.state.profile ?? const UserEntity())
                            .copyWith(selectedLanguage: 'english'),
                      );
                      AppHaptics.light();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isEnglish ? AppColors.vi : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isEnglish
                          ? [
                              BoxShadow(
                                color: AppColors.vi.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: Text(
                      'EN',
                      style: TextStyle(
                        color: isEnglish ? Colors.white : Colors.white54,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (isEnglish) {
                      profileController.updateProfile(
                        (profileController.state.profile ?? const UserEntity())
                            .copyWith(selectedLanguage: 'twi'),
                      );
                      AppHaptics.light();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: !isEnglish ? AppColors.vi : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: !isEnglish
                          ? [
                              BoxShadow(
                                color: AppColors.vi.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: Text(
                      'TWI',
                      style: TextStyle(
                        color: !isEnglish ? Colors.white : Colors.white54,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
