import 'package:equatable/equatable.dart';

class GraphModel extends Equatable {
  final String date;
  final String weekDay;
  final int totalExpenses;
  final double totalAmount;

  const GraphModel({
    required this.date,
    required this.weekDay,
    this.totalExpenses = 0,
    required this.totalAmount,
  });

  GraphModel copyWith({String? date, String? weekDay, int? totalExpenses, double? totalAmount}) {
    return GraphModel(
        date: date ?? this.date,
        weekDay: weekDay ?? this.weekDay,
        totalExpenses: totalExpenses ?? this.totalExpenses,
        totalAmount: totalAmount ?? this.totalAmount
    );}

  @override
  List<Object?> get props => [date, weekDay, totalExpenses, totalAmount];
}
