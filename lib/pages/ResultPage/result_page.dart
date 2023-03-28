import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'widgets/custom_button.dart';
import 'widgets/result_average_banner.dart';
import 'widgets/result_chart.dart';
import 'widgets/result_details_banner.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.CUSTOM_APPBAR(
          context: context, title: "Result", buttonText: "Close"),
      body: LayoutBuilder(
        builder: (context, constrains) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: constrains.maxWidth * .03,
              vertical: constrains.maxWidth * .02,
            ),
            decoration: BoxDecoration(color: Constants.LIGHT_BLUE_COLOR),
            child: Column(
              children: [
                ResultAverageBanner(constrains: constrains),
                Flexible(flex: 1, child: Container()),
                ResultChart(constrains: constrains),
                Flexible(flex: 1, child: Container()),
                ResultDetailsBanner(constrains: constrains),
                Flexible(flex: 1, child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      constrains: constrains,
                      icon: Constants.TEST_REVIEW_ICON,
                      buttonText: "Test Review",
                    ),
                    CustomButton(
                      constrains: constrains,
                      icon: Constants.RETEST_ICON,
                      buttonText: "Re Test",
                    ),
                  ],
                ),
                Flexible(flex: 1, child: Container()),
                CustomButton(
                  constrains: constrains,
                  icon: Constants.CLOSE_ICON,
                  buttonText: "Exit",
                ),
                Flexible(flex: 1, child: Container()),
              ],
            ),
          );
        },
      ),
    );
  }
}
