import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../utils/constants.dart';

class ResultChart extends StatelessWidget {
  final BoxConstraints constrains;
  const ResultChart({
    super.key,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: const {"Right": 8, "Wrong": 1, "Skipped": 1},
      chartLegendSpacing: constrains.maxHeight * .03,
      chartRadius: constrains.maxWidth * .45,
      colorList: [
        Constants.DARK_BLUE_COLOR,
        Colors.red,
        Constants.BLUE_COLOR,
      ],
      initialAngleInDegree: 30,
      // ringStrokeWidth: 32,
      // centerText: "HYBRID",
      legendOptions: const LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.rectangle,
        legendTextStyle: TextStyle(
          // fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: false,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 0,
        chartValueStyle: TextStyle(
          color: Constants.DARK_BLACK_COLOR,
        ),
      ),
    );
  }
}
