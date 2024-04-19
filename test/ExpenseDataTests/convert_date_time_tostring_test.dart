
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/data/expense_data/expense_data.dart';

void main(){

  // Getting Current DateTime
  DateTime dateTime = DateTime.now();

  // Year in the format of yyyy
  String year = dateTime.year.toString();

  // Month in the format of mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // Day in the format dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format => yyyymmdd
  String expected = year + month + day;

  // Testing the method to converting date to String.
  test('Testing the DateTime to String', () {

    // Getting the result of convertDateTimeToString method.
    final String result = ExpenseData.convertDateTimeToString(dateTime);

    // Compare the Results.
    expect(result, expected);

  });

}