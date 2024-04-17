import 'package:personal_expense_tracker_app/models/graph_model.dart';
import '../../models/expense_item.dart';
import 'expense_data.dart';

class GraphDataClass {
  // Get graph data and we will call it on every event and it will return List of
  // GraphModel.
  // This list length must be 7 because we will show the weekly summary including today.
  static Future<List<GraphModel>> getGraphData(
      List<ExpenseItem> expensesList) async {
    // Initialize the temporary list that we will return at end and manipulate it.
    List<GraphModel> tempGraphData = [];
    // Get the today date.
    DateTime today = DateTime.now();
    // Loop for getting the previous 7 days.
    for (int i = 0; i < 7; i++) {
      // Nested Loop for Expense List at every day.
      for (int j = 0; j < expensesList.length; j++) {
        // Compare the each day with expense list items that any expense found on this day or not.
        if (ExpenseData.convertDateTimeToString(expensesList[j].dateTime) ==
            ExpenseData.convertDateTimeToString(today)) {
          // Below two variables for identify the founded item index and for condition.
          late int replaceAbleIndex;
          bool isFound = false;
          // This most nested loop is for searching the founded item in tempGraphData
          // if exist then we will add it in it to handle multiple expenses in a single day.
          // if not exist then we will make new entry.
          for (int index = 0; index < tempGraphData.length; index++) {
            // Check for the date matches or not if So then will will add in existing
            // item else we will make new entry.
            if (ExpenseData.convertDateTimeToString(
                    DateTime.parse(tempGraphData[index].date)) ==
                ExpenseData.convertDateTimeToString(expensesList[j].dateTime)) {
              // print('Item Found: ${expensesList[j]}');
              // Set those variables.
              replaceAbleIndex = index;
              isFound = true;
            } else {
              // print('Item not Found: ${expensesList[j]}');
              isFound = false;
            }
          }
          // IF found is true then we will add in existing amount and totalExpenses++.
          if (isFound) {
            tempGraphData[replaceAbleIndex] = GraphModel(
                date: tempGraphData[replaceAbleIndex].date,
                totalExpenses:
                    tempGraphData[replaceAbleIndex].totalExpenses + 1,
                weekDay: ExpenseData.getDayName(expensesList[j].dateTime),
                totalAmount: ExpenseData.singleBarRodVerticalAxis(
                    tempGraphData[replaceAbleIndex].totalExpenses + 1,
                    tempGraphData[replaceAbleIndex].totalAmount +
                        double.parse(expensesList[j].amount)));
          }
          // Else simply add the new Item.
          else {
            tempGraphData.add(GraphModel(
                date: ExpenseData.convertDateTimeToString(
                    expensesList[j].dateTime),
                totalExpenses: 1,
                weekDay: ExpenseData.getDayName(expensesList[j].dateTime),
                totalAmount: ExpenseData.singleBarRodVerticalAxis(
                    1, double.parse(expensesList[j].amount))));
          }
        }
      }
      // Subtract the one day per Iteration.
      today = today.subtract(const Duration(days: 1));
    }
    // Finally Check for the length of tempGraphData that must be 7
    // if length less than 7 then we will add missing days with empty data
    // to show the graph seamlessly.
    if (tempGraphData.length < 7) {
      // Calling the static function named getMissingWeekDays that required the list of data.
      return tempGraphData = ExpenseData.getMissingWeekDays(tempGraphData);
    }
    // Else we will simply return it as it is.
    else {
      return tempGraphData;
    }
    // print('Sorted GraphData: $graphData');
  }
}
