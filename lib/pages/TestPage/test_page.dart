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
            leadingButtonText: testController.getIsTestStart ? "Stop" : null,
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
                // testController.setIsTestStart = true;
                // testController.update();
                // testController.testTimer();
                Get.back();
              }
            },
            buttonText: testController.getRemainingTime,
            buttonPressFunction: () {},
            title: "Quiz",
          ),
          body: LayoutBuilder(
            builder: (_, constrains) => Container(
              color: Constants.LIGHT_BLUE_COLOR,
              padding: EdgeInsets.all(
                constrains.maxWidth * .03,
              ),
              child: Stack(
                children: [
                  Column(
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
                        height: constrains.maxHeight * .60,
                        child: Container(
                          padding: EdgeInsets.all(
                            constrains.maxWidth * .02,
                          ),
                          height: constrains.maxHeight * .60,
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
                                  color: Constants.LIGHT_BLUE_COLOR,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: constrains.maxHeight * .01,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (_, index) => SizedBox(
                                  height: constrains.maxHeight * .11,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: constrains.maxHeight * .010,
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
                                      testController.getIsTestStart
                                          ? const SizedBox()
                                          : Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    15,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 5,
                                                      blurStyle:
                                                          BlurStyle.inner,
                                                      color: Constants
                                                          .LIGHT_BLUE_COLOR
                                                          .withOpacity(.9),
                                                    ),
                                                  ]),
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
                          if (testController.getIsTestStart) {
                            testController.setUserTestMcqs(
                              userMcqs: testController.getSelectedMcqs[
                                  testController.getCurrentMcqsIndex],
                              userEnteredAnswer: "Skipped",
                            );

                            if (testController.getSelectedMcqs.length ==
                                testController.getCurrentMcqsIndex + 1) {
                              print(testController.getSelectedMcqs.length);
                              print(testController.getCurrentMcqsIndex);
                              Get.toNamed(Routes.getResultPage());
                            }
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
                  testController.getIsTestStart
                      ? const SizedBox()
                      : Container(
                          width: double.infinity,
                          color: Constants.LIGHT_BLUE_COLOR.withOpacity(.95),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text:
                                          "Please carefully read the message: ",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    TextSpan(
                                      text:
                                          "When you click on the option below question, whether intentionally or unintentionally, next question will be displayed, and the selected option will be considered your answer. If the allotted time elapses, the test will be automatically closed, and you will be redirected to the result page.\nThe quiz comprises ${testController.getSelectedMcqs.length} Mcqs focused on the ${testController.getSelectedMcqs[0].category}.",
                                      // style: TextStyle(color: Colors.red),
                                    ),
                                    const TextSpan(
                                      text:
                                          "\nTo initiate the test, kindly click on the 'START' button.",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              // Text(
                              //   "Please carefully read the message: When you click on the option inside the circle, whether intentionally or unintentionally, the question will be displayed, and the selected option will be considered your answer. If the allotted time elapses, the test will be automatically closed, and you will be redirected to the result page. To initiate the test, kindly click on the 'Start' button.",
                              //   textAlign: TextAlign.justify,
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //   ),
                              // ),
                              ElevatedButton(
                                onPressed: () {
                                  testController.setIsTestStart = true;
                                  testController.update();
                                  testController.testTimer();
                                },
                                child: const Text("START"),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
