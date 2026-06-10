import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/services/tts_service.dart';
import 'package:ntentan/features/dashboard/presentation/models/dashboard_action_item.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/feature_card.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/voice_assistant_modal.dart';
import 'package:ntentan/features/settings/presentation/controllers/medication_controller.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final medicationState = context.watch<MedicationController>().state;
    final untakenMedsList = medicationState.untakenMedicationsToday;
    final remainingCount = untakenMedsList.length;

    final actions =
        DashboardActionItem.getActions(remainingCount: remainingCount);

    void handleActionTap(DashboardActionItem action) {
      switch (action.type) {
        case DashboardActionType.meds:
          final tts = GetIt.I<TtsService>();
          if (remainingCount == 0) {
            tts.speak('You have no remaining medicines for today.');
          } else if (remainingCount == 1) {
            tts.speak('You have 1 remaining medicine today: ${untakenMedsList.first}.');
          } else {
            final last = untakenMedsList.last;
            final others = untakenMedsList.sublist(0, remainingCount - 1).join('. ');
            tts.speak('You have $remainingCount remaining medicines today: $others. And $last.');
          }
          break;
        case DashboardActionType.modal:
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const VoiceAssistantModal(),
          );
          break;
        case DashboardActionType.route:
          if (action.routePath != null) {
            context.push(action.routePath!);
          }
          break;
      }
    }

    return Column(
      children: [
        for (var i = 0; i < actions.length; i += 2)
          Padding(
            padding: EdgeInsets.only(
              bottom: i + 2 < actions.length ? AppSizes.space16 : 0,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: FeatureCard(
                      title: actions[i].title,
                      description: actions[i].description,
                      routePath: actions[i].routePath ?? '',
                      color: actions[i].color,
                      icon: actions[i].icon,
                      onTapOverride: () => handleActionTap(actions[i]),
                    ),
                  ),
                  const SizedBox(width: AppSizes.space16),
                  Expanded(
                    child: i + 1 < actions.length
                        ? FeatureCard(
                            title: actions[i + 1].title,
                            description: actions[i + 1].description,
                            routePath: actions[i + 1].routePath ?? '',
                            color: actions[i + 1].color,
                            icon: actions[i + 1].icon,
                            onTapOverride: () =>
                                handleActionTap(actions[i + 1]),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
