import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_app/res/app_colors/app_colors.dart';
import '../app_text_styles/text_styles.dart';

// App re use able Text form field which is used in Dialog boxes.
class ReUseAbleTextFormField extends StatelessWidget {
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final TextEditingController textEditingController;
  final String hintText;
  final String labelText;
  final int? maxlen;
  final Function(dynamic)? validator;
  final Function(dynamic)? onFieldSubmitted;
  final Function(String)? onKeyUp;
  final Function(dynamic)? onTapOutSide;
  const ReUseAbleTextFormField(
      {super.key,
        required this.focusNode,
        required this.textEditingController,
        required this.hintText,
        required this.labelText,
        this.maxlen,
        this.validator,
        this.keyboardType,
        this.onFieldSubmitted,
        this.onKeyUp,
        this.onTapOutSide});
  @override
  Widget build(BuildContext context) {
    // Getting the current brightness mode of app.
    Brightness mode = Theme.of(context).brightness;
    return TextFormField(
      keyboardType: keyboardType,
      style: AppTextStyles.subTitleStyle(
        fontSize: 16,
        color: mode == Brightness.dark
            ? AppColors.normalTextColorDark
            : AppColors.normalTextColorLight
      ),
      maxLength: maxlen,
      focusNode: focusNode,
      cursorColor: mode == Brightness.dark
          ? AppColors.themeColorDark
          : AppColors.themeColorLight,
      controller: textEditingController,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.subTitleStyle(
              fontSize: 16,
              color: mode == Brightness.dark
                  ? AppColors.normalTextColorDark
                  : AppColors.normalTextColorLight
          ),
          hintText: hintText,
          hintStyle: AppTextStyles.subTitleStyle(
            fontSize: 16,
            color: mode == Brightness.dark
                ? AppColors.normalTextColorDark
                : AppColors.normalTextColorLight
          ),
          fillColor: mode == Brightness.dark
              ? AppColors.darkModeScaffoldColor.withOpacity(.5)
              : AppColors.lightModeScaffoldColor.withOpacity(.5),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mode == Brightness.dark
                  ? AppColors.normalBorderColorDark
                  : AppColors.normalBorderColorLight,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: mode == Brightness.dark
                    ? AppColors.normalBorderColorDark
                    : AppColors.normalBorderColorLight,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.errorBorderColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.errorBorderColor,
                width: 2,
              ))),
      onChanged: onKeyUp,
      validator: (value) => validator!(value),
      onFieldSubmitted: (value) => onFieldSubmitted!(value),
      onTapOutside: onTapOutSide,
    );
  }
}