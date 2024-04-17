import '../../models/expense_item.dart';
import '../../models/graph_model.dart';

class ExpenseData {

  // get week day(Mon, Tue, Wed, etc) from a datetime object.
  static String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // This function returns the average of daily expenses and we handle
  // only 20 entries a day if user exceeds then it will be logical error.
  static double singleBarRodVerticalAxis(int expenses, double totalAmount) {
    switch (expenses) {
      case 1:
        return totalAmount / 100 * 100;
      case 2:
        return totalAmount / 200 * 100;
      case 3:
        return totalAmount / 300 * 100;
      case 4:
        return totalAmount / 400 * 100;
      case 5:
        return totalAmount / 500 * 100;
      case 6:
        return totalAmount / 600 * 100;
      case 7:
        return totalAmount / 700 * 100;
      case 8:
        return totalAmount / 800 * 100;
      case 9:
        return totalAmount / 900 * 100;
      case 10:
        return totalAmount / 1000 * 100;
      case 11:
        return totalAmount / 1100 * 100;
      case 12:
        return totalAmount / 1200 * 100;
      case 13:
        return totalAmount / 1300 * 100;
      case 14:
        return totalAmount / 1400 * 100;
      case 15:
        return totalAmount / 1500 * 100;
      case 16:
        return totalAmount / 1600 * 100;
      case 17:
        return totalAmount / 1700 * 100;
      case 18:
        return totalAmount / 1800 * 100;
      case 19:
        return totalAmount / 900 * 100;
      case 20:
        return totalAmount / 2000 * 100;
      default:
        return 0.0;
    }
  }

  // Get the list of missing week days from graph list and
  // add them with date and null data to show the graph perfectly
  static List<GraphModel> getMissingWeekDays(List<GraphModel> graphList) {
    DateTime dateTime = DateTime.now();
    List<int> daysList = [];
    int i = 0;
    // Loop for enter Weekdays as integer in daysList[] that we initialize above as empty.
    while (i < 7) {
      daysList.add(DateTime.parse(convertDateTimeToString(dateTime)).day);
      dateTime = dateTime.subtract(const Duration(days: 1));
      i++;
    }
    // Loop to check for existing week days in a list and remove them
    // The result will be consist on only missing week days.
    for (int i = 0; i < graphList.length; i++) {
      if (daysList.contains(DateTime.parse(graphList[i].date).day)) {
        daysList
            .removeAt(daysList.indexOf(DateTime.parse(graphList[i].date).day));
      }
    }
    // Now we will add those missing days in the given graphList with accurate date.
    for (var days in daysList) {
      DateTime currentDate = dateTime.copyWith(day: days);
      graphList.add(GraphModel(
          date: convertDateTimeToString(currentDate),
          weekDay: getDayName(currentDate),
          totalExpenses: 0,
          totalAmount: 0.0));
    }
    // Sort the graphList in an ascending order on the behalf of date.
    graphList.sort((a, b) =>
        DateTime.parse(a.date).day.compareTo(DateTime.parse(b.date).day));
    // finally return the final sorted list
    return graphList;
  }

  // Convert DateTime to String in this format: 20240416(yyyymmdd).
  static String convertDateTimeToString(DateTime dateTime) {
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
    String yyyymmdd = year + month + day;

    return yyyymmdd;
  }

  // Get weekly total expenses Summary.
  static double getWeeklyTotalExpenses (List<GraphModel> graphList) {
    double weeklyTotal = 0.0;
    for(var graphItem in graphList){
      weeklyTotal += graphItem.totalAmount;
    }
    return weeklyTotal;
  }

  // Get the the total of expenses all Expenses.
  static double getTotalExpenses (List<ExpenseItem> expensesList) {
    double totalExpenses = 0.0;
    for(var expenseItem in expensesList){
      totalExpenses += double.parse(expenseItem.amount);
    }
    return totalExpenses;
  }

}
