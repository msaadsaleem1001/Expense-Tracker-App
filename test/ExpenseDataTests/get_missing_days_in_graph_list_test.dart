
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/data/expense_data/expense_data.dart';
import 'package:personal_expense_tracker_app/models/graph_model.dart';

void main() {

  // Getting Current Date.
  DateTime dateTime = DateTime.now();
  // Getting previous date from current.
  dateTime = dateTime.subtract(const Duration(days: 1));
  // Demo List with missing week days.
  List<GraphModel> missingWeekDaysList = [
    GraphModel(
      date: ExpenseData.convertDateTimeToString(dateTime),
      weekDay: ExpenseData.getDayName(dateTime),
      totalAmount: 0.0,
      totalExpenses: 0
    )
  ];
  // List of week days
  final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  test('Get the missing days in Graph List', () {

    // Step 1: Getting the result of Missing Week days.
    final List<GraphModel> resultGraph = ExpenseData.getMissingWeekDays(missingWeekDaysList);

    // Step 2: Loop on resultGraph List to check that all week days are present in it or not.
    for(var graphItem in resultGraph){

      // Step 3: Check for dynamic weekDay in List and it will check on each iteration.
      expect(graphItem.weekDay, weekDays[weekDays.indexOf(graphItem.weekDay)]);
      // debugPrint('Graph week Day: ${graphItem.weekDay}');
      // debugPrint('Week List Day: ${weekDays[weekDays.indexOf(graphItem.weekDay)]}');
    }

  });

}