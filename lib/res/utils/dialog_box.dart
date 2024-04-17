import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense_tracker_app/models/expense_item.dart';
import 'package:personal_expense_tracker_app/res/app_colors/app_colors.dart';
import 'package:personal_expense_tracker_app/res/app_text_styles/text_styles.dart';
import 'package:personal_expense_tracker_app/res/components/re_useable_row.dart';
import 'package:personal_expense_tracker_app/res/components/text_form_field.dart';
import '../../view_model/bloc/expense_bloc/expense_bloc.dart';
import '../../view_model/bloc/expense_bloc/expense_event.dart';
import '../../view_model/bloc/expense_bloc/expense_state.dart';

// App Utilities.
class AppUtils {
  // Dialog for add the expense.
  static Future<void> dialogAddExpense(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();
    final focusTitle = FocusNode();
    final focusDesc = FocusNode();
    final focusAmount = FocusNode();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text('Add Expense'),
          ),
          content: Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    ReUseAbleTextFormField(
                      labelText: 'Title',
                      hintText: 'Enter Title',
                      focusNode: focusTitle,
                      onFieldSubmitted: (val) {
                        focusTitle.unfocus();
                        FocusScope.of(context).requestFocus(focusAmount);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        } else if (value.length >= 3) {
                          return null;
                        } else {
                          return 'Enter title at least 3 characters';
                        }
                      },
                      maxlen: 50,
                      keyboardType: TextInputType.text,
                      textEditingController: titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReUseAbleTextFormField(
                      labelText: 'Amount',
                      hintText: 'Enter Amount',
                      focusNode: focusAmount,
                      onFieldSubmitted: (val) {
                        focusAmount.unfocus();
                        FocusScope.of(context).requestFocus(focusDesc);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        } else if (value.toString().isNotEmpty) {
                          return null;
                        } else {
                          return 'Enter amount';
                        }
                      },
                      maxlen: 2,
                      keyboardType: TextInputType.number,
                      textEditingController: amountController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReUseAbleTextFormField(
                      labelText: 'Description',
                      hintText: 'Enter Description',
                      focusNode: focusDesc,
                      onFieldSubmitted: (val) {
                        focusDesc.unfocus();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        } else if (value.length >= 20) {
                          return null;
                        } else {
                          return 'Description at least 20 characters';
                        }
                      },
                      maxlen: 150,
                      keyboardType: TextInputType.text,
                      textEditingController: descriptionController,
                    ),
                    BlocBuilder<ExpenseBloc, ExpenseState>(
                      buildWhen: (previous, current) =>
                          previous.addingExpense != current.addingExpense,
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: state.addingExpense ? false : true,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel')),
                              ),
                              const SizedBox(width: 20),
                              state.addingExpense
                                  ? const Padding(
                                      padding: EdgeInsets.only(right: 25),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(),
                                      ))
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          context.read<ExpenseBloc>().add(
                                              AddExpenseEvent(
                                                  item: ExpenseItem(
                                                      title: titleController
                                                          .text
                                                          .toString()
                                                          .trim(),
                                                      desc:
                                                          descriptionController
                                                              .text
                                                              .toString()
                                                              .trim(),
                                                      amount: amountController
                                                          .text
                                                          .toString()
                                                          .trim(),
                                                      dateTime: DateTime.now()),
                                                  context: context));
                                        }
                                      },
                                      child: const Text('Add')),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

  // Dialog for the Update Expense.
  static Future<void> dialogUpdateExpense(
      int listId, BuildContext context, ExpenseItem item) {
    final formKey = GlobalKey<FormState>();
    TextEditingController titleController =
        TextEditingController(text: item.title);
    TextEditingController descriptionController =
        TextEditingController(text: item.desc);
    TextEditingController amountController =
        TextEditingController(text: item.amount);
    final focusTitle = FocusNode();
    final focusDesc = FocusNode();
    final focusAmount = FocusNode();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Update Expense')),
          content: Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    ReUseAbleTextFormField(
                      labelText: 'Title',
                      hintText: 'Enter Title',
                      focusNode: focusTitle,
                      onKeyUp: (val) {
                        titleController.text = val;
                      },
                      onTapOutSide: (val) {
                        focusTitle.unfocus();
                      },
                      onFieldSubmitted: (val) {
                        titleController.text = val;
                        focusTitle.unfocus();
                        FocusScope.of(context).requestFocus(focusAmount);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        } else if (value.length >= 3) {
                          return null;
                        } else {
                          return 'Enter title at least 3 characters';
                        }
                      },
                      maxlen: 50,
                      keyboardType: TextInputType.text,
                      textEditingController: titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReUseAbleTextFormField(
                      labelText: 'Amount',
                      hintText: 'Enter Amount',
                      focusNode: focusAmount,
                      onTapOutSide: (val) {
                        focusAmount.unfocus();
                      },
                      onKeyUp: (val) {
                        amountController.text = val;
                      },
                      onFieldSubmitted: (val) {
                        amountController.text = val;
                        focusAmount.unfocus();
                        FocusScope.of(context).requestFocus(focusDesc);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        } else if (value.toString().isNotEmpty) {
                          return null;
                        } else {
                          return 'Enter amount';
                        }
                      },
                      maxlen: 2,
                      keyboardType: TextInputType.number,
                      textEditingController: amountController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReUseAbleTextFormField(
                      labelText: 'Description',
                      hintText: 'Enter Description',
                      focusNode: focusDesc,
                      onTapOutSide: (val) {
                        focusDesc.unfocus();
                      },
                      onKeyUp: (val) {
                        descriptionController.text = val;
                      },
                      onFieldSubmitted: (val) {
                        descriptionController.text = val;
                        focusDesc.unfocus();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        } else if (value.length >= 20) {
                          return null;
                        } else {
                          return 'Description at least 20 characters';
                        }
                      },
                      maxlen: 150,
                      keyboardType: TextInputType.text,
                      textEditingController: descriptionController,
                    ),
                    BlocBuilder<ExpenseBloc, ExpenseState>(
                      buildWhen: (previous, current) =>
                          previous.addingExpense != current.addingExpense,
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: state.addingExpense ? false : true,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel')),
                              ),
                              const SizedBox(width: 20),
                              state.addingExpense
                                  ? const Padding(
                                      padding: EdgeInsets.only(right: 35),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(),
                                      ))
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          context.read<ExpenseBloc>().add(
                                              UpdateExpenseEvent(
                                                  item: ExpenseItem(
                                                      id: item.id,
                                                      title: titleController
                                                          .text
                                                          .toString()
                                                          .trim(),
                                                      desc:
                                                          descriptionController
                                                              .text
                                                              .toString()
                                                              .trim(),
                                                      amount: amountController
                                                          .text
                                                          .toString()
                                                          .trim(),
                                                      dateTime: item.dateTime),
                                                  listId: listId,
                                                  context: context));
                                        }
                                      },
                                      child: const Text('Update')),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

  // Dialog to show the details of a Expense.
  static Future<void> dialogShowExpense(
      BuildContext context, ExpenseItem item) {
    Brightness mode = Theme.of(context).brightness;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(item.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleStyle(
                    fontSize: 22,
                    color: mode == Brightness.dark
                        ? AppColors.appWhite
                        : AppColors.appBlack)),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item.desc,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleStyle(
                          fontSize: 14,
                          color: mode == Brightness.dark
                              ? AppColors.appWhite.withOpacity(.6)
                              : AppColors.appBlack.withOpacity(.6))),
                  const SizedBox(height: 20),
                  AppReUseAbleRow(title: 'Amount:', amount: item.amount),
                ],
              ),
            ));
      },
    );
  }
}
