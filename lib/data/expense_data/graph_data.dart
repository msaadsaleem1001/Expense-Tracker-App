import 'package:personal_expense_tracker_app/models/graph_model.dart';
import '../../models/expense_item.dart';
import 'expense_data.dart';

class GraphDataClass {

  static Future<List<GraphModel>> getGraphData(List<ExpenseItem> expensesList) async{
    List<GraphModel> tempGraphData = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < expensesList.length; j++) {
        if (ExpenseData.convertDateTimeToString(expensesList[j].dateTime) ==
            ExpenseData.convertDateTimeToString(today)) {
          late int replaceAbleIndex;
          bool isFound = false;
          for (int index = 0; index < tempGraphData.length; index++) {
            if (ExpenseData.convertDateTimeToString(
                DateTime.parse(tempGraphData[index].date)) ==
                ExpenseData.convertDateTimeToString(expensesList[j].dateTime)) {
              // print('Item Found: ${expensesList[j]}');
              replaceAbleIndex = index;
              isFound = true;
            } else {
              // print('Item not Found: ${expensesList[j]}');
              isFound = false;
            }
          }
          if (isFound) {
            tempGraphData[replaceAbleIndex] = GraphModel(
                date: tempGraphData[replaceAbleIndex].date,
                totalExpenses:
                tempGraphData[replaceAbleIndex].totalExpenses + 1,
                weekDay: ExpenseData.getDayName(expensesList[j].dateTime),
                totalAmount: ExpenseData.singleBarRodVerticalAxis(
                    tempGraphData[replaceAbleIndex].totalExpenses + 1,
                    tempGraphData[replaceAbleIndex].totalAmount + double.parse(expensesList[j].amount)));
          } else {
            tempGraphData.add(GraphModel(
                date: ExpenseData.convertDateTimeToString(
                    expensesList[j].dateTime),
                totalExpenses: 1,
                weekDay: ExpenseData.getDayName(expensesList[j].dateTime),
                totalAmount: ExpenseData.singleBarRodVerticalAxis(1, double.parse(expensesList[j].amount))));
          }
        }
      }
      today = today.subtract(const Duration(days: 1));
    }
    if(tempGraphData.length < 7){
      return tempGraphData = ExpenseData.getMissingWeekDays(tempGraphData);
    }
    else{
      return tempGraphData;
    }
    // print('Sorted GraphData: $graphData');
  }
}