import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/test_controller.dart';
import '../../../utils/constants.dart';

class ResultDetailsBanner extends StatelessWidget {
  final BoxConstraints constrains;
  const ResultDetailsBanner({
    super.key,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(builder: (testController) {
      return Container(
        // margin: EdgeInsets.symmetric(
        //     horizontal: constrains.maxWidth * .1),
        padding: EdgeInsets.all(
          constrains.maxWidth * .02,
        ),
        decoration: BoxDecoration(
          color: Constants.BLUE_COLOR,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "Score",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
                Text(
                  "${((testController.getObtainedMarks / (testController.getSelectedMcqs.length)) * 100).toInt()}/100",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Right",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
                Text(
                  testController.getObtainedMarks.toInt().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Wrong",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
                Text(
                  "${testController.getSelectedMcqs.length - (testController.getObtainedMarks + testController.getSkippedMcqs).toInt()}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Skipped",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
                Text(
                  testController.getSkippedMcqs.toInt().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
