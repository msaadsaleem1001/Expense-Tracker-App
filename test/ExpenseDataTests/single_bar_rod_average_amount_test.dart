
// import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/data/expense_data/expense_data.dart';

void main(){

  test('Get the average of every each bar vertical rod data.', () {
    double expectedResult = 75/100 * 100;
    double result = 0.0;
    int i = 1;
    double totalExpenses = 75;
    // Loop for testing all cases.
    while(i < 20){

      // Step 1: Get the dummy data.
      result = ExpenseData.singleBarRodVerticalAxis(i, totalExpenses);

      // Step 2: Matching results.
      expect(result, expectedResult);

      // Increment by 100;
      totalExpenses = totalExpenses + 100;
      // Increment the i by 1
      i++;
      // Update the expected result.
      expectedResult = totalExpenses / int.parse('${i.toString()}00') * 100;
      // debugPrint('Actual i is: $i');
      // debugPrint('Divided by: ${i.toString()}00');
      // debugPrint('Total Expenses: ${totalExpenses.toString()}');
      // debugPrint('Actual result is: ${result.toString()}');
      // debugPrint('Expected result is: ${result.toString()}');
    }

  });
}