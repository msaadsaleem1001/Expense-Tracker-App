import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_app/res/app_colors/app_colors.dart';
import '../../../models/graph_model.dart';
import 'graph_bottom_titles.dart';

class ExpenseBarGraph extends StatelessWidget {
  final List<GraphModel> graphData;
  const ExpenseBarGraph({
    super.key,
    required this.graphData,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    Brightness mode = Theme.of(context).brightness;
    return SizedBox(
        height: 200,
        width: width,
        child: BarChart(BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          minY: 0,
          titlesData: FlTitlesData(
            show: true,
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) =>
                        GraphBottomTitles.getBottomTitles(value, meta, mode, graphData))),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          backgroundColor: mode == Brightness.dark
              ? AppColors.darkModeScaffoldColor
              : AppColors.lightModeScaffoldColor,
          barGroups: List.generate(graphData.length, (index) {
            // debugPrint('Bar Data: ${barData[index].y.toString()}');
            return BarChartGroupData(x: index, barRods: [
              BarChartRodData(
                  toY: double.parse(
                      graphData[index].totalAmount.toStringAsFixed(2)),
                  width: 25,
                  color: mode == Brightness.dark
                      ? AppColors.themeColorDark
                      : AppColors.themeColorLight,
                  borderRadius: BorderRadius.circular(5),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 100,
                    color: mode == Brightness.dark
                        ? AppColors.darkModeRodBackgroundColor
                        : AppColors.lightModeRodBackgroundColor,
                  )),
            ]);
          }),
        )));
  }
}
