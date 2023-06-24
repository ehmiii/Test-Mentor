import 'package:flutter/material.dart';
import 'package:gat_cs_trainer_app/controllers/home_controller.dart';
import 'package:gat_cs_trainer_app/controllers/test_controller.dart';
import 'package:gat_cs_trainer_app/utils/widgets/show_toast.dart';
import 'package:get/get.dart';

import '../../../models/mcqs_model.dart';
import '../../../utils/Routes/routes.dart';
import '../../../utils/constants.dart';

// This widget is use to represent GAT Test Page macqs
class McqsWidget extends StatelessWidget {
  final int index;
  final BoxConstraints constraints;
  final Map<String, String> mcqs;
  // final Map<String, String> mcqsOptionWithNo;
  const McqsWidget({
    super.key,
    required this.index,
    required this.mcqs,
    required this.constraints,
    // required this.mcqsOptionWithNo,
  });
  @override
  Widget build(BuildContext context) {
    final _userAnswerQuestion = Get.find<TestController>()
        .getUserAnsweredQuestions!
        .firstWhere((element) => element!["Question"] == mcqs["Question"],
            orElse: () => null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q-${index + 1}: ${mcqs["Question"]![0].capitalize}${mcqs["Question"]!.substring(1)}",
          style: TextStyle(
            fontSize: 15,
            color: Constants.DARK_BLUE_COLOR,
          ),
        ),
        // ...mcqs.keys
        //     .map((key) => Text("$key: ${mcqsOptionWithNo[key]}"))
        //     .toList(),
        Text(
          "A) ${mcqs["A"]}",
        ),
        Text(
          "B) ${mcqs["B"]}",
          // style: TextStyle(
          //   color:
          //       Get.find<TestController>().getSelectedMcqs[index].rightAnswer ==
          //               mcqs["B"]
          //           ? Colors.green
          //           : Colors.red,
          // ),
        ),
        Text(
          "C) ${mcqs["C"]}",
          // style: TextStyle(
          //   color:
          //       Get.find<TestController>().getSelectedMcqs[index].rightAnswer ==
          //               mcqs["C"]
          //           ? Colors.green
          //           : Colors.red,
          // ),
        ),
        Text(
          "D) ${mcqs["D"]}",
          // style: TextStyle(
          //   color:
          //       Get.find<TestController>().getSelectedMcqs[index].rightAnswer ==
          //               mcqs["D"]
          //           ? Colors.green
          //           : Colors.red,
          // ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: mcqs.keys
              .map(
                (optionNo) => optionNo == "Question"
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(
                          left: constraints.maxWidth * .02,
                          right: constraints.maxWidth * .02,
                          top: constraints.maxWidth * .02,
                        ),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                splashColor: Constants.DARK_BLUE_COLOR,
                                onTap: _userAnswerQuestion != null
                                    ? null
                                    : () {
                                        final _testController =
                                            Get.find<TestController>();
                                        print(mcqs[optionNo]);
                                        _testController.setClickedMcqsOption =
                                            optionNo;
                                        _testController.setUserTestMcqs(
                                            userMcqs: _testController
                                                .getSelectedMcqs[index],
                                            userEnteredAnswer: mcqs[optionNo]!);
                                        if (_testController
                                                .getSelectedMcqs[index]
                                                .rightAnswer ==
                                            mcqs[optionNo]) {
                                          _testController.setObtainedMarks =
                                              _testController.getObtainedMarks +
                                                  1;
                                        } else {
                                          Get.find<TestController>()
                                                  .setWrongAnswerByUser =
                                              Get.find<TestController>()
                                                      .getWrongAnswerByUser +
                                                  1;
                                        }
                                        _testController.update();
                                        if (_testController
                                                    .getSelectedMcqs.length -
                                                _testController
                                                    .getUserTestMcqsModel
                                                    .length ==
                                            0) {
                                          ShowToast.SHOW_TOAST(
                                              "Please wait while we calculate your result.");
                                          Future.delayed(const Duration(seconds: 2));
                                          _testController.setIsTestStart =
                                              false;
                                          _testController.getTimer!.cancel();
                                          Get.toNamed(Routes.getResultPage());
                                        }
                                      },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(
                                    constraints.maxWidth * .02,
                                  ),
                                  // margin: EdgeInsets.symmetric(
                                  //   horizontal: constraints.maxWidth * .02,
                                  // ),
                                  decoration: BoxDecoration(
                                    color: _userAnswerQuestion != null &&
                                            _userAnswerQuestion["Option"] ==
                                                mcqs[optionNo]
                                        ? Colors.black
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Constants.DARK_BLUE_COLOR,
                                    ),
                                  ),
                                  child: Text(
                                    optionNo,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              )
              .toList(),
        ),
      ],
    );
  }
}
