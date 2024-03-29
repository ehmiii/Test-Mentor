import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/test_controller.dart';
import '/utils/constants.dart';

class TimeDownCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(
      builder: (testController) => Text(
        "Total Duration:  ${Constants.FORMATE_TIME(testController.getTotalTime)}",
        style: TextStyle(
          color: Constants.DARK_BLUE_COLOR,
          fontSize: 30,
        ),
      ),
    );
  }
}
