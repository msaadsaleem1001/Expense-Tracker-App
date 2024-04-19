
import 'dart:math';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/data/expense_data/expense_data.dart';
import 'package:personal_expense_tracker_app/data/expense_data/graph_data.dart';
import 'package:personal_expense_tracker_app/models/expense_item.dart';
import 'package:personal_expense_tracker_app/models/graph_model.dart';

void main(){

  // Step 1: Get Date of now.
  DateTime date = DateTime.now();

  // Step 2: Empty List of Expense Model;
  List<ExpenseItem> expenseList = [];

  // Step 3 Random integer between 0 to 100,
  Random random = Random();

  // Step 4: Inserting in empty list.
  for(int i = 0; i < 10; i++){
    expenseList.add(
      ExpenseItem(
        id: null,
        title: '',
        desc: '',
        amount: random.nextInt(100).toString(),
        dateTime: DateTime.parse(ExpenseData.convertDateTimeToString(date))));
    date = date.subtract(const Duration(days: 1));
  }

  // Step 5: Test method to get the graph list from all expenses List.
  test('Get Graph List from the list of all expenses', () async{

    // Getting the List of graph from function.
    final List<GraphModel> result = await GraphDataClass.getGraphData(expenseList);

    DateTime dateTime = DateTime.now();

    // Loop on result.
    for(int i = 0; i < 7; i++){
      // Finally Compare the value.
      expect(DateTime.parse(result[result.indexOf(result[i])].date).day, dateTime.day);
      // debugPrint('Result Day: ${DateTime.parse(result[result.indexOf(result[i])].date).day}');
      // debugPrint('DateTime Day: ${dateTime.day}');
      dateTime = dateTime.subtract(const Duration(days: 1));
    }

  });
}