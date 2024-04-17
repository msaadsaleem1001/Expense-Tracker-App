import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';
import '../app_text_styles/text_styles.dart';
// App theme data class it has two static methods for getting the light & dark mode.
class ExpenseAppThemeData {
  // Light theme data getter.
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: AppColors.lightModeScaffoldColor,
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      shadowColor: AppColors.themeColorLight,
      elevation: 2,
      iconTheme: const IconThemeData(color: AppColors.appWhite, size: 25),
      actionsIconTheme: const IconThemeData(color: AppColors.appWhite, size: 25),
      surfaceTintColor: AppColors.themeColorLight,
      backgroundColor: AppColors.lightModeAppBarColor,
      foregroundColor: AppColors.appWhite,
      centerTitle: true,
      titleTextStyle: AppTextStyles.titleStyle(fontSize: 16, color: AppColors.appWhite),
    ),
    listTileTheme: ListTileThemeData(
        enableFeedback: false,
        style: ListTileStyle.drawer,
        titleTextStyle: AppTextStyles.titleStyle(
            fontSize: 18, color: AppColors.appBlack),
        subtitleTextStyle: AppTextStyles.subTitleStyle(
            fontSize: 16, color: AppColors.appBlack.withOpacity(0.7)),
        leadingAndTrailingTextStyle: AppTextStyles.titleStyle(
            fontSize: 18, color: AppColors.appBlack.withOpacity(0.7))),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.lightModeDialogColor,
      elevation: 2,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      shadowColor: AppColors.themeColorLight.withOpacity(.4),
      alignment: Alignment.center,
      actionsPadding: const EdgeInsets.only(right: 10, top: 20, bottom: 10),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightModeAppBarColor,
      enableFeedback: false,
      iconSize: 30,
      foregroundColor: AppColors.appWhite,
      splashColor: AppColors.themeColorLight.withOpacity(.5),
      elevation: 3,
    ),
  );

  // Dark mode theme data getter.
  static ThemeData get dark => ThemeData(
      scaffoldBackgroundColor: AppColors.darkModeScaffoldColor,
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        shadowColor: AppColors.themeColorDark,
        elevation: 2,
        iconTheme: const IconThemeData(color: AppColors.appWhite, size: 25),
        actionsIconTheme: const IconThemeData(color: AppColors.appWhite, size: 25),
        surfaceTintColor: AppColors.themeColorDark,
        backgroundColor: AppColors.darkModeAppBarColor,
        foregroundColor: AppColors.appWhite,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleStyle(fontSize: 16, color: AppColors.appWhite),
      ),
      iconButtonTheme:
          const IconButtonThemeData(style: ButtonStyle(enableFeedback: false)),
      listTileTheme: ListTileThemeData(
          enableFeedback: false,
          style: ListTileStyle.drawer,
          titleTextStyle: AppTextStyles.titleStyle(
              fontSize: 18, color: AppColors.appWhite),
          subtitleTextStyle: AppTextStyles.subTitleStyle(
              fontSize: 16, color: AppColors.appWhite.withOpacity(0.7)),
          leadingAndTrailingTextStyle: AppTextStyles.titleStyle(
              fontSize: 18, color: AppColors.appWhite.withOpacity(0.7))),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.darkModeDialogColor,
        elevation: 2,
        titleTextStyle: AppTextStyles.titleStyle(fontSize: 16, color: AppColors.appWhite),
        contentTextStyle: AppTextStyles.subTitleStyle(fontSize: 14, color: AppColors.appWhite),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        shadowColor: AppColors.themeColorDark.withOpacity(.4),
        alignment: Alignment.center,
        actionsPadding: const EdgeInsets.only(right: 10, top: 20, bottom: 10),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkModeDialogColor,
        enableFeedback: false,
        iconSize: 30,
        foregroundColor: AppColors.themeColorLight,
        splashColor: AppColors.themeColorLight.withOpacity(.3),
        elevation: 3,
      ));
}
