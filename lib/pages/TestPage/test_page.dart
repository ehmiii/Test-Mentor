import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:testmentor/controllers/test_controller.dart';
import 'package:testmentor/utils/Routes/routes.dart';

import 'package:testmentor/utils/constants.dart';

import '../../utils/widgets/custom_appbar.dart';
import 'widgets/custom_button.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  CountdownTimerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = CountdownTimerController(
      endTime:
          Duration(seconds: Get.find<TestController>().getTotalTime).inMinutes,
      onEnd: () => Get.offAndToNamed(
        Routes.getResultPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(
      builder: (testController) {
        return Scaffold(
          appBar: CustomAppBar.CUSTOM_APPBAR(
            context: context,
            leadingButtonText: testController.getIsTestStart ? "Stop" : "Start",
            leadingButtonPressFunction: () {
              if (testController.getIsTestStart) {
                Get.offAndToNamed(Routes.getResultPage());
              } else {}
            },
            buttonText:
                "${Duration(seconds: testController.getTotalTime).inMinutes}:00 min",
            buttonPressFunction: () {},
            title: "Quiz",
          ),
          body: LayoutBuilder(
            builder: (_, constrains) => Container(
              color: Constants.LIGHT_BLUE_COLOR,
              padding: EdgeInsets.all(
                constrains.maxWidth * .03,
              ),
              child: Column(
                children: [
                  Text(
                    "Total Mcqs: ${testController.getSelectedMcqs.length}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Constants.DARK_BLACK_COLOR,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                      constrains.maxWidth * .02,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Constants.DARK_BLUE_COLOR.withOpacity(.7),
                    ),
                    child: Column(
                      children: [
                        Text(
                          testController
                              .getSelectedMcqs[
                                  testController.getCurrentMcqsIndex]
                              .question,
                          style: TextStyle(
                            color: Constants.DARK_BLACK_COLOR,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: constrains.maxHeight * .02,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_, index) => SizedBox(
                            height: constrains.maxHeight * .11,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: constrains.maxHeight * .013,
                                  ),
                                  height: constrains.maxHeight * .11,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Constants.BLUE_COLOR,
                                        Constants.LIGHT_BLUE_COLOR,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Constants.DARK_BLACK_COLOR
                                            .withOpacity(.5),
                                        offset: const Offset(
                                          3,
                                          3,
                                        ),
                                        blurRadius: 4,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(
                                      15,
                                    ),
                                  ),
                                  child: Text(
                                    testController.getCurrentMcqsAnswers[index],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Constants.DARK_BLACK_COLOR,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: constrains.maxHeight * .013,
                                  ),
                                  height: constrains.maxHeight * .11,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      splashColor: Constants.DARK_BLUE_COLOR,
                                      onTap: () {
                                        testController.nextQuestion();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount:
                              testController.getCurrentMcqsAnswers.length,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Current Mcqs: ${testController.getCurrentMcqsIndex + 1}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Constants.DARK_BLACK_COLOR,
                        ),
                      ),
                      Text(
                        "Left Mcqs: ${testController.getSelectedMcqs.length - 1 - testController.getCurrentMcqsIndex}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Constants.DARK_BLACK_COLOR,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  CustomButton(
                    icon: Constants.SKIP_ICON,
                    buttonText: "Skip",
                    constrains: constrains,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        horizontal: constrains.maxWidth * .02),
                    height: constrains.maxHeight * .1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Constants.BLUE_COLOR,
                          Constants.LIGHT_BLUE_COLOR,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.DARK_BLACK_COLOR.withOpacity(.5),
                          offset: const Offset(
                            3,
                            3,
                          ),
                          blurRadius: 4,
                        ),
                      ],
                    ),

                    // child: CountdownTimer(
                    //   controller: _controller,
                    //   onEnd: () => Get.offAndToNamed(
                    //     Routes.getResultPage(),
                    //   ),
                    //   widgetBuilder: (context, time) {
                    //     return Text(
                    //       "Left Time: ${time!.min}Min ${time.sec}Sec",
                    //       style: TextStyle(
                    //         color: Constants.DARK_BLACK_COLOR,
                    //         fontSize: 20,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
