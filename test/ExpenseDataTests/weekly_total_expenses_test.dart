
import 'dart:math';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/data/expense_data/expense_data.dart';
import 'package:personal_expense_tracker_app/models/graph_model.dart';

void main(){

  double weeklyTotal = 0.0;

  // Step 1: Get Date of now.
  DateTime date = DateTime.now();

  // Step 2: Empty List of Graph Model;
  List<GraphModel> graphModel = [];

  // Step 3 Random integer between 0 to 100,
  Random random = Random();

  // Step 4: Inserting in list.
  for(int i = 0; i < 7; i++){
    graphModel.add(
      GraphModel(
          date: ExpenseData.convertDateTimeToString(date),
          weekDay: ExpenseData.getDayName(date),
          totalExpenses: 1,
          totalAmount: double.parse(random.nextInt(100).toString())
      )
    );
    date = date.subtract(const Duration(days: 1));
  }

  // debugPrint('Graph Model List: $graphModel');

  for(var graphItem in graphModel){
    weeklyTotal += graphItem.totalAmount;
  }

  // Step 5: Test the method to get the total weekly expenses expenses.
  test('Get Weekly total expenses', () {

    // Getting the total amount from function.
    final double result = ExpenseData.getWeeklyTotalExpenses(graphModel);

    // Finally Compare the value.
    expect(result, weeklyTotal);

  });
}