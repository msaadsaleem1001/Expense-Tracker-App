import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:personal_expense_tracker_app/res/app_colors/app_colors.dart';
// Expense tile widget to show each expense.
class ExpenseTile extends StatelessWidget {
  final String title;
  final String amount;
  final String description;
  final DateTime dateTime;
  final void Function(BuildContext)? onEditPressed;
  final void Function(BuildContext)? onDelPressed;
  final void Function() onTap;
  const ExpenseTile({
    super.key,
    required this.title,
    required this.amount,
    required this.description,
    required this.dateTime,
    required this.onEditPressed,
    required this.onDelPressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // getting the width of screen.
    final width = MediaQuery.sizeOf(context).width * 1;
    // getting the current mode.
    Brightness mode = Theme.of(context).brightness;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
      // SlideAble widget to make a tile slide able.
      child: Slidable(
          // Make it slide able from left for update.
          startActionPane: ActionPane(
            extentRatio: .15,
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),
            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                padding: EdgeInsets.zero,
                onPressed: onEditPressed,
                backgroundColor: mode == Brightness.dark
                    ? AppColors.darkModeScaffoldColor
                    : AppColors.lightModeScaffoldColor,
                foregroundColor: mode == Brightness.dark
                    ? AppColors.appWhite
                    : AppColors.editColor,
                icon: Icons.edit_calendar_rounded,
                spacing: 0,
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            extentRatio: .15,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: onDelPressed,
                backgroundColor: mode == Brightness.dark
                    ? AppColors.darkModeScaffoldColor
                    : AppColors.lightModeScaffoldColor,
                foregroundColor: AppColors.delColor,
                icon: Icons.delete,
                spacing: 0,
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: mode == Brightness.dark
                  ? AppColors.listTileColorDark
                  : AppColors.listTileColorLight,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              onTap: onTap,
              title: Text(title),
              subtitle: Text(
                  '${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}'),
              trailing: Text('\$${amount.toString()}'),
            ),
          )
        ),
    );
  }
}
