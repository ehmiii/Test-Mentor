import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/test_controller.dart';
import '../../../utils/constants.dart';

class ResultAverageBanner extends StatelessWidget {
  final BoxConstraints constrains;
  const ResultAverageBanner({
    super.key,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(builder: (testController) {
      return Row(
        children: [
          Container(
            width: constrains.maxWidth * .7,
            height: constrains.maxWidth * .15,
            padding: EdgeInsets.symmetric(
                horizontal: constrains.maxWidth * .03,
                vertical: constrains.maxWidth * .02),
            decoration: BoxDecoration(
              color: Constants.BLUE_COLOR,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            child: LayoutBuilder(builder: (context, cons) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: cons.maxWidth * .7,
                    child: Stack(
                      children: [
                        Container(
                          width: cons.maxWidth * .7,
                          height: cons.maxWidth * .08,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: ((testController.getObtainedMarks /
                              testController.getSelectedMcqs.length)),
                          child: Container(
                            width: cons.maxWidth * .5,
                            height: cons.maxWidth * .08,
                            decoration: BoxDecoration(
                              color: Constants.DARK_BLUE_COLOR,
                              borderRadius: testController.getObtainedMarks ==
                                      testController.getSelectedMcqs.length
                                  ? BorderRadius.circular(50)
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${testController.getObtainedMarks.toInt()} out of ${testController.getSelectedMcqs.length}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Constants.LIGHT_BLUE_COLOR,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          Container(
            width: constrains.maxWidth * .23,
            height: constrains.maxWidth * .15,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Constants.DARK_BLUE_COLOR,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${((testController.getObtainedMarks / (testController.getSelectedMcqs.length)) * 100).toStringAsFixed(2)}%",
                  style: TextStyle(
                    fontSize: 18,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
                Text(
                  "Average",
                  style: TextStyle(
                    fontSize: 18,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
