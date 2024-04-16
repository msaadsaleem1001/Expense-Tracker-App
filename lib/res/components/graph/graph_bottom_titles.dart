
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../models/graph_model.dart';
import '../../app_colors/app_colors.dart';
import '../../app_text_styles/text_styles.dart';

class GraphBottomTitles {

  static Widget getBottomTitles(
      double value, TitleMeta meta, Brightness mode, List<GraphModel> graphData) {
    final TextStyle style = AppTextStyles.titleStyle(
        fontSize: 10,
        color: mode == Brightness.dark
            ? AppColors.titleTextColorDark
            : AppColors.titleTextColorLight);
    final TextStyle dateStyle = AppTextStyles.titleStyle(
        fontSize: 8,
        color: mode == Brightness.dark
            ? AppColors.titleTextColorDark
            : AppColors.titleTextColorLight);
    final TextStyle todayStyle =
    AppTextStyles.titleStyle(fontSize: 12, color: AppColors.lightModeAppBarColor);
    Widget column;
    switch (value.toInt()) {
      case 0:
        column = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(graphData[0].weekDay, style: style),
            const SizedBox(height: 5),
            Text(
                '${DateTime.parse(graphData[0].date).day}/${DateTime.parse(graphData[0].date).month}',
                style: dateStyle),
          ],
        );
        break;
      case 1:
        column = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(graphData[1].weekDay, style: style),
            const SizedBox(height: 5),
            Text(
                '${DateTime.parse(graphData[1].date).day}/${DateTime.parse(graphData[1].date).month}',
                style: dateStyle),
          ],
        );
        break;
      case 2:
        column = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(graphData[2].weekDay, style: style),
            const SizedBox(height: 5),
            Text(
                '${DateTime.parse(graphData[2].date).day}/${DateTime.parse(graphData[2].date).month}',
                style: dateStyle),
          ],
        );
        break;
      case 3:
        column = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(graphData[3].weekDay, style: style),
            const SizedBox(height: 5),
            Text(
                '${DateTime.parse(graphData[3].date).day}/${DateTime.parse(graphData[3].date).month}',
                style: dateStyle),
          ],
        );
        break;
      case 4:
        column = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(graphData[4].weekDay, style: style),
            const SizedBox(height: 5),
            Text(
                '${DateTime.parse(graphData[4].date).day}/${DateTime.parse(graphData[4].date).month}',
                style: dateStyle),
          ],
        );
        break;
      case 5:
        column = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(graphData[5].weekDay, style: style),
            const SizedBox(height: 5),
            Text(
                '${DateTime.parse(graphData[5].date).day}/${DateTime.parse(graphData[5].date).month}',
                style: dateStyle),
          ],
        );
        break;
      case 6:
        column = Column(
          children: [
            Text(graphData[6].weekDay, style: todayStyle),
            const SizedBox(height: 5),
            Text(
                '${DateTime.parse(graphData[6].date).day}/${DateTime.parse(graphData[6].date).month}',
                style: todayStyle),
          ],
        );
        break;
      default:
        column = Column(
          children: [
            Text('', style: style),
            const SizedBox(height: 5),
            Text('', style: style),
          ],
        );
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: column);
  }

}