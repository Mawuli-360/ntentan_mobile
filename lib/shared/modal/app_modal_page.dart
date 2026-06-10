import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/app_spacing.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/shared/widgets/app_text.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

SliverWoltModalSheetPage buildAppModalPage(
    {required String title,
    required Widget child,
    bool showCloseButton = true,
    Color backgroundColor = AppColors.surface,
    Color surfaceTintColor = Colors.transparent,
    double navBarHeight = 1.0,
    double? fontSize,
    FontWeight? fontWeight}) {
  Widget buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppText(
                title,
                fontSize: fontSize ?? AppSizes.space16,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
            if (showCloseButton)
              GestureDetector(
                onTap: () {
                  if (WoltModalSheet.of(context).currentPageIndex == 0) {
                    Navigator.of(context).pop();
                  } else {
                    WoltModalSheet.of(context).showPrevious();
                  }
                },
                child: Container(
                  padding: AppSpacing.a4,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(color: AppColors.borderColor, width: 2),
                    ),
                  ),
                  child: const Icon(Icons.close),
                ),
              ),
          ],
        ),
        Divider(
          color: AppColors.borderColor,
          thickness: 1,
          height: AppSizes.space32,
        )
      ],
    );
  }

  return SliverWoltModalSheetPage(
    surfaceTintColor: surfaceTintColor,
    navBarHeight: navBarHeight,
    backgroundColor: backgroundColor,
    mainContentSliversBuilder: (context) {
      return [
        SliverToBoxAdapter(
          child: Padding(
            padding: AppSpacing.a12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildHeader(context),
                const SizedBox(height: 8),
                child,
              ],
            ),
          ),
        ),
      ];
    },
  );
}
