import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/data/expense_data/expense_data.dart';
import 'package:personal_expense_tracker_app/models/expense_item.dart';

void main() {
  double totalExpenses = 0.0;

  // Step 1: Get Date of now.
  DateTime date = DateTime.now();

  // Step 2: Empty List of Graph Model;
  List<ExpenseItem> expenseList = [];

  // Step 3 Random integer between 0 to 100,
  Random random = Random();

  // Step 4: Inserting in list.
  for (int i = 0; i < 7; i++) {
    expenseList.add(ExpenseItem(
        id: null,
        title: '',
        desc: '',
        amount: random.nextInt(100).toString(),
        dateTime: date));
    date = date.subtract(const Duration(days: 1));
  }

  for (var item in expenseList) {
    totalExpenses += double.parse(item.amount);
  }

  // Step 5: Test the method to get the total expenses expenses.
  test('Get total expenses', () {
    // Getting the total expenses from function.
    final double result = ExpenseData.getTotalExpenses(expenseList);

    // Finally Compare the values.
    expect(result, totalExpenses);
  });
}
