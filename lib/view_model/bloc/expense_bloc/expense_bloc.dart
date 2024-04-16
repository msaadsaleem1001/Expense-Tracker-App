import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_app/models/graph_model.dart';
import '../../../data/expense_data/expense_data.dart';
import '../../../data/expense_data/graph_data.dart';
import '../../../models/expense_item.dart';
import '../../../repository/sqlite_repo/ExpenseRepository.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseDatabaseRepository db;
  List<ExpenseItem> overAllExpenseList = [];
  List<GraphModel> graphData = [];
  double totalExpenses = 0.0;
  double weeklySummary = 0.0;
  bool addingExpense = false;

  ExpenseBloc(this.db) : super(const ExpenseState()) {
    on<AddExpenseEvent>(_addExpense);
    on<UpdateExpenseEvent>(_updateExpense);
    on<DeleteExpenseEvent>(_deleteExpense);
    on<GetAllExpenses>(_getAllExpenses);
  }

  void _addExpense(AddExpenseEvent event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(
        addingExpense: true,
        totalExpenses: totalExpenses,
        weeklySummary: weeklySummary));
    await Future.delayed(const Duration(milliseconds: 2000))
        .whenComplete(() async {
      await db.insert(expenseItem: event.item).whenComplete(() async {
        overAllExpenseList.clear();
        overAllExpenseList = await db.getAllExpenses();
        graphData = await GraphDataClass.getGraphData(overAllExpenseList);
        overAllExpenseList = List.from(overAllExpenseList.reversed);
        totalExpenses = ExpenseData.getTotalExpenses(overAllExpenseList);
        weeklySummary = ExpenseData.getWeeklyTotalExpenses(graphData);
        emit(state.copyWith(
            overAllExpenseList: List.from(overAllExpenseList),
            graphData: List.from(graphData),
            addingExpense: false,
            totalExpenses: totalExpenses,
            weeklySummary: weeklySummary));
        Navigator.pop(event.context);
      });
    });
  }

  void _updateExpense(
      UpdateExpenseEvent event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(
        addingExpense: true,
        totalExpenses: totalExpenses,
        weeklySummary: weeklySummary));
    await Future.delayed(const Duration(milliseconds: 2000))
        .whenComplete(() async {
      await db.update(event.item).whenComplete(() async {
        overAllExpenseList.removeAt(event.listId);
        overAllExpenseList.insert(event.listId, event.item);
        graphData = await GraphDataClass.getGraphData(overAllExpenseList);
        overAllExpenseList = List.from(overAllExpenseList.reversed);
        totalExpenses = ExpenseData.getTotalExpenses(overAllExpenseList);
        weeklySummary = ExpenseData.getWeeklyTotalExpenses(graphData);
        emit(state.copyWith(
            overAllExpenseList: List.from(overAllExpenseList),
            graphData: List.from(graphData),
            addingExpense: false,
            totalExpenses: totalExpenses,
            weeklySummary: weeklySummary));
        Navigator.pop(event.context);
      });
    });
  }

  void _deleteExpense(
      DeleteExpenseEvent event, Emitter<ExpenseState> emit) async {
    await db.delete(event.expenseId).whenComplete(() async {
      overAllExpenseList.removeAt(event.listIndex);
      graphData = await GraphDataClass.getGraphData(overAllExpenseList);
      overAllExpenseList = List.from(overAllExpenseList.reversed);
      totalExpenses = ExpenseData.getTotalExpenses(overAllExpenseList);
      weeklySummary = ExpenseData.getWeeklyTotalExpenses(graphData);
      emit(state.copyWith(
          overAllExpenseList: List.from(overAllExpenseList),
          graphData: List.from(graphData),
          totalExpenses: totalExpenses,
          weeklySummary: weeklySummary));
    });
  }

  void _getAllExpenses(GetAllExpenses event, Emitter<ExpenseState> emit) async {
    overAllExpenseList.clear();
    overAllExpenseList = await db.getAllExpenses();
    graphData = await GraphDataClass.getGraphData(overAllExpenseList);
    overAllExpenseList = List.from(overAllExpenseList.reversed);
    totalExpenses = ExpenseData.getTotalExpenses(overAllExpenseList);
    weeklySummary = ExpenseData.getWeeklyTotalExpenses(graphData);
    // print(graphData);
    emit(state.copyWith(
        overAllExpenseList: List.from(overAllExpenseList),
        graphData: List.from(graphData),
        totalExpenses: totalExpenses,
        weeklySummary: weeklySummary));
  }
}
