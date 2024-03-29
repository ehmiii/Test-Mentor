import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '/controllers/signup_controller.dart';
import '/controllers/test_controller.dart';
import '/pages/ResultPage/widgets/review_test.dart';
import '/utils/Routes/routes.dart';
import '/utils/widgets/show_toast.dart';

import '../../utils/constants.dart';
import '../../utils/data/test_report_generator_as_pdf.dart';
import '../../utils/widgets/custom_appbar.dart';
import '../McqsPage/widgets/test_mcqs_selection_dialog.dart';
import 'widgets/custom_button.dart';
import 'widgets/result_average_banner.dart';
import 'widgets/result_chart.dart';
import 'widgets/result_details_banner.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
          ..pop()
          ..pop();
        return false;
      },
      child: Scaffold(
        appBar: Get.isRegistered<SignUpController>()
            ? AppBar(
                title: Text(
                  "Result",
                  style: TextStyle(
                    color: Constants.LIGHT_BLUE_COLOR,
                    fontSize: 20,
                  ),
                ),
                leading: const SizedBox(),
                centerTitle: true,
              )
            : CustomAppBar.CUSTOM_APPBAR(
                context: context,
                title: "Result",
                buttonText: "Close",
                buttonPressFunction: () {
                  Get.until((route) => route.settings.name == Routes.home);
                },
              ),
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
                  Get.isRegistered<SignUpController>()
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextButton(
                              child: const Text("Go to Sing up"),
                              onPressed: () {
                                final result = (Get.find<TestController>()
                                            .getObtainedMarks *
                                        Get.find<TestController>()
                                            .getSelectedMcqs
                                            .length) /
                                    100;

                                if (result >= 80) {
                                  Get.find<SignUpController>().setIsQuizPassed =
                                      true;
                                  Get.until(
                                    (route) =>
                                        route.settings.name == Routes.signup,
                                  );
                                  ShowToast.SHOW_TOAST(
                                      "Congrats! you passed the test");
                                } else {
                                  Get.until(
                                    (route) =>
                                        route.settings.name == Routes.signup,
                                  );
                                  ShowToast.SHOW_TOAST(
                                      "Your score:$result. Unable to get required marks");
                                }
                              },
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment:
                              Get.find<HomeController>().getUserChoice ==
                                      "GATTest"
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              constrains: constrains,
                              // icon: Constants.TEST_REVIEW_ICON,
                              buttonText: "Test Review",
                              press: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ReviewTestMcqs.REVIEW_TEST_MCQS(
                                    context,
                                    Get.find<TestController>()
                                        .getUserTestMcqsModel,
                                  ),
                                  // barrierDismissible: false,
                                  barrierLabel: "Review",
                                  barrierColor:
                                      Constants.DARK_BLUE_COLOR.withOpacity(.7),
                                );
                              },
                            ),
                            Get.find<HomeController>().getUserChoice ==
                                    "GATTest"
                                ? const SizedBox()
                                : CustomButton(
                                    constrains: constrains,
                                    // icon: Constants.RETEST_ICON,
                                    buttonText: "Re Test",
                                    press: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            TestMcqsSelectionDialog
                                                .TEST_MCQS_SELECTION_DIALOG(
                                                    context,
                                                    isRetest: true),
                                        barrierDismissible: false,
                                        barrierLabel: "Select Length of Mcqs",
                                        barrierColor: Constants.DARK_BLUE_COLOR
                                            .withOpacity(.7),
                                      );
                                    },
                                  ),
                          ],
                        ),
                  Get.isRegistered<SignUpController>()
                      ? const SizedBox()
                      : Flexible(flex: 1, child: Container()),
                  Get.isRegistered<SignUpController>()
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GetBuilder<TestController>(
                                builder: (testController) {
                              return CustomButton(
                                constrains: constrains,
                                // icon: Constants.CLOSE_ICON,
                                buttonText: "Generate Report",
                                press: () {
                                  if (true) {
                                    // if (!testController.getIsReportGenerated) {
                                    TestReportGeneratorAsPdf
                                        .TEST_REPORT_GENERATOR_AS_PDF(
                                      subject: testController
                                          .getSelectedMcqs[0].category,
                                      mcqsLength: testController
                                          .getSelectedMcqs.length
                                          .toDouble(),
                                      time: testController.getTotalTime,
                                      obtainedMarks:
                                          testController.getObtainedMarks,
                                      wrongMcqs: testController
                                          .getWrongAnswerByUser
                                          .toInt(),
                                      rightMcqs: testController.getObtainedMarks
                                          .toInt(),
                                      skippedMcqs:
                                          testController.getSkippedMcqs.toInt(),
                                      examTakingTime:
                                          testController.getExamTakingTime,
                                    );
                                    testController.setIsReportGenerated = true;
                                  }
                                },
                              );
                            }),
                            CustomButton(
                              constrains: constrains,
                              // icon: Constants.CLOSE_ICON,
                              buttonText: "Exit",
                              press: () => Get.until((route) =>
                                  route.settings.name == Routes.home),
                            ),
                          ],
                        ),
                  Get.isRegistered<SignUpController>()
                      ? const SizedBox()
                      : Flexible(flex: 1, child: Container()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
