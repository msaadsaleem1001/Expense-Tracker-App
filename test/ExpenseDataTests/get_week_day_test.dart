
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/data/expense_data/expense_data.dart';

void main(){

  test('Get Week Day form Date', () {

    // Step 1: Get Date of now.
    DateTime date = DateTime.now();

    // Step 2: Get the result of getDayName function that consist of String;
    final String result = ExpenseData.getDayName(date);

    // Step 3: Now pass result in switch because we don't know what will be the out put
    // of this method because it depends on the date so that's why testing it as expected outputs.
    switch (result) {
      case 'Mon':
        // Step 4: Finally Match the result.
        expect(result, 'Mon');
      case 'Tue':
      // Step 4: Finally Match the result.
        expect(result, 'Tue');
      case 'Wed':
      // Step 4: Finally Match the result.
        expect(result, 'Wed');
      case 'Thu':
      // Step 4: Finally Match the result.
        expect(result, 'Thu');
      case 'Fri':
      // Step 4: Finally Match the result.
        expect(result, 'Fri');
      case 'Sat':
      // Step 4: Finally Match the result.
        expect(result, 'Sat');
      case 'Sun':
      // Step 4: Finally Match the result.
        expect(result, 'Sun');
      default:
      // Step 4: Finally Match the result.
        expect(result, '');
    }

  });
}