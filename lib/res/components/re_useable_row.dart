import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';
import '../app_text_styles/text_styles.dart';

class AppReUseAbleRow extends StatelessWidget {
  final String title;
  final String amount;
  const AppReUseAbleRow({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    Brightness mode = Theme.of(context).brightness;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: AppTextStyles.titleStyle(
                    fontSize: 14,
                    color: mode == Brightness.dark
                        ? AppColors.appWhite.withOpacity(.6)
                        : AppColors.appBlack.withOpacity(.6))),
            Text('\$$amount',
                style: AppTextStyles.titleStyle(
                    fontSize: 14,
                    color: mode == Brightness.dark
                        ? AppColors.appWhite.withOpacity(.6)
                        : AppColors.appBlack.withOpacity(.6))),
          ],
        ));
  }
}
