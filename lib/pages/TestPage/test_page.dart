import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/test_controller.dart';
import '/pages/TestPage/widgets/time_down_counter.dart';
import '/utils/Routes/routes.dart';

import '/utils/constants.dart';

import '../../utils/widgets/custom_appbar.dart';
import 'widgets/custom_button.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

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
                testController.setSkippedMcqs =
                    testController.getSelectedMcqs.length -
                        (testController.getObtainedMarks +
                            testController.getWrongAnswerByUser);
                testController.setIsTestStart = false;
                testController.getTimer!.cancel();
                Get.toNamed(Routes.getResultPage());
              } else {
                testController.setIsTestStart = true;
                testController.update();
                testController.testTimer();
              }
            },
            buttonText: Constants.FORMATE_TIME(testController.getTotalTime),
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
                  SizedBox(
                    height: constrains.maxHeight * .57,
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                            constrains.maxWidth * .02,
                          ),
                          height: constrains.maxHeight * .57,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Constants.DARK_BLUE_COLOR.withOpacity(.7),
                          ),
                          child: Column(
                            children: [
                              AutoSizeText(
                                testController
                                    .getSelectedMcqs[
                                        testController.getCurrentMcqsIndex]
                                    .question,
                                maxLines: 3,
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
                                          testController
                                              .getCurrentMcqsAnswers[index],
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            splashColor:
                                                Constants.DARK_BLUE_COLOR,
                                            onTap: () {
                                              testController.setUserTestMcqs(
                                                userMcqs: testController
                                                        .getSelectedMcqs[
                                                    testController
                                                        .getCurrentMcqsIndex],
                                                userEnteredAnswer: testController
                                                        .getCurrentMcqsAnswers[
                                                    index],
                                              );
                                              if (testController
                                                          .getCurrentMcqsAnswers[
                                                      index] ==
                                                  testController
                                                      .getSelectedMcqs[
                                                          testController
                                                              .getCurrentMcqsIndex]
                                                      .rightAnswer) {
                                                testController
                                                        .setObtainedMarks =
                                                    testController
                                                            .getObtainedMarks +
                                                        1;
                                              } else {
                                                testController
                                                        .setWrongAnswerByUser =
                                                    testController
                                                            .getWrongAnswerByUser +
                                                        1;
                                              }
                                              if (testController
                                                          .getCurrentMcqsIndex +
                                                      1 ==
                                                  testController
                                                      .getSelectedMcqs.length) {
                                                Get.toNamed(
                                                    Routes.getResultPage());
                                              } else {
                                                testController.nextQuestion();
                                              }
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
                        testController.getIsTestStart
                            ? const SizedBox()
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      15,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.inner,
                                        color: Constants.LIGHT_BLUE_COLOR
                                            .withOpacity(.9),
                                      ),
                                    ]),
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
                    press: () {
                      testController.setUserTestMcqs(
                        userMcqs: testController.getSelectedMcqs[
                            testController.getCurrentMcqsIndex],
                        userEnteredAnswer: "Skipped",
                      );
                      if (testController.getIsTestStart) {
                        testController.nextQuestion();
                        testController.setSkippedMcqs =
                            testController.getSkippedMcqs + 1;
                      }
                    },
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
                    child: TimeDownCounter(),
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
