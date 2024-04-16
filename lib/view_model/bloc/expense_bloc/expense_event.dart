
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:personal_expense_tracker_app/models/expense_item.dart';

abstract class ExpenseEvent extends Equatable{

  const ExpenseEvent();

  @override
  List<Object?> get props => [];

}

class AddExpenseEvent extends ExpenseEvent {

  final ExpenseItem item;
  final BuildContext context;

  const AddExpenseEvent({required this.item, required this.context});

  @override
  List<Object?> get props => [item, context];

}

class UpdateExpenseEvent extends ExpenseEvent {

  final ExpenseItem item;
  final int listId;
  final BuildContext context;

  const UpdateExpenseEvent({
    required this.item,
    required this.listId,
    required this.context
  });

  @override
  List<Object?> get props => [item, listId, context];

}

class DeleteExpenseEvent extends ExpenseEvent {

  final int expenseId;
  final int listIndex;

  const DeleteExpenseEvent({
    required this.expenseId,
    required this.listIndex,
  });

  @override
  List<Object?> get props => [expenseId, listIndex];

}

class GetAllExpenses extends ExpenseEvent {
  const GetAllExpenses();

  @override
  List<Object?> get props => [];
}
