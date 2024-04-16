
import 'package:equatable/equatable.dart';
import '../../../models/expense_item.dart';
import '../../../models/graph_model.dart';

class ExpenseState extends Equatable{
  final List<ExpenseItem> overAllExpenseList;
  final List<GraphModel> graphData;
  final bool addingExpense;
  final double totalExpenses;
  final double weeklySummary;

  const ExpenseState({
    this.overAllExpenseList = const [],
    this.graphData = const [],
    this.addingExpense = false,
    this.totalExpenses = 0.0,
    this.weeklySummary = 0.0
  });

  ExpenseState copyWith({
    List<ExpenseItem>? overAllExpenseList,
    List<GraphModel>? graphData,
    bool? addingExpense,
    required double totalExpenses,
    required double weeklySummary
  }){
    return ExpenseState(
      overAllExpenseList: overAllExpenseList ?? this.overAllExpenseList,
      graphData: graphData ?? this.graphData,
      addingExpense: addingExpense ?? this.addingExpense,
      totalExpenses: totalExpenses,
      weeklySummary: weeklySummary
    );
  }

  @override
  List<Object?> get props => [
    overAllExpenseList,
    graphData,
    addingExpense,
    totalExpenses,
    weeklySummary
  ];

}