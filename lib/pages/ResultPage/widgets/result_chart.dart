import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '/controllers/test_controller.dart';

import '../../../utils/constants.dart';

class ResultChart extends StatelessWidget {
  final BoxConstraints constrains;
  const ResultChart({
    super.key,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(builder: (testController) {
      return PieChart(
        dataMap: {
          "Right": testController.getObtainedMarks,
          "Wrong": testController.getWrongAnswerByUser,
          "Skipped": testController.getSkippedMcqs,
        },
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
    });
  }
}
