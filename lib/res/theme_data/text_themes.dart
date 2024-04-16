
import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';
import '../app_text_styles/text_styles.dart';


class ExpenseAppTextThemes {
  static TextTheme lightTextTheme = TextTheme(

      titleLarge: AppTextStyles.titleStyle(color: AppColors.titleTextColorLight),

      titleMedium: AppTextStyles.subTitleStyle(color: AppColors.titleTextColorLight),

      bodySmall: AppTextStyles.bodyStyle(color: AppColors.normalTextColorLight),


  );

  static TextTheme darkTextTheme = TextTheme(

    titleLarge: AppTextStyles.titleStyle(color: AppColors.titleTextColorDark),

    titleMedium: AppTextStyles.subTitleStyle(color: AppColors.titleTextColorDark),

    bodySmall: AppTextStyles.bodyStyle(color: AppColors.normalTextColorDark),
  );
}
