import 'package:flutter/material.dart';
import 'package:gat_cs_trainer_app/controllers/test_controller.dart';
import '../../controllers/home_controller.dart';
import '../../models/mcqs_model.dart';
import '../../models/subjects_model.dart';
import '../../utils/Routes/routes.dart';
import '../../utils/constants.dart';
import '../../utils/data/categories_names.dart';
import '../../utils/extensions/random_list_generation_extension.dart';
import '../../utils/widgets/custom_appbar.dart';
import 'package:get/get.dart';

import '../../utils/widgets/show_toast.dart';
import 'widgets/mcqs.dart';

class GatTestSimulationPage extends StatelessWidget {
  const GatTestSimulationPage({super.key});

  // List<McqsModel> selectedMcqs = [];
  // void getSelectedMcqs() {
  //   selectedMcqs = [];
  //   // Following variable stores lenght of mcqs of each subject for computer science
  //   List<int> computerPrecentages = [
  //     10,
  //     7,
  //     4,
  //     4,
  //     6,
  //     9,
  //     7,
  //     6,
  //     5,
  //     5,
  //     5,
  //     5,
  //     6,
  //     6,
  //     5,
  //     5,
  //     5,
  //   ];

  //   // Following variable stores lenght of mcqs of each subject for computer science
  //   List<int> englishPrecentage = [15, 15];
  //   // Following map variable stores subject name and there length of mcqs to be picked
  //   List<Map<String, int>> computerSubjects = [];
  //   List<Map<String, int>> englishSubjects = [];

  //   // Following list stores picked mcqs for test
  //   List<McqsModel> computerSciencePickedMcqs = [];
  //   List<McqsModel> englishPickedMcqs = [];

  //   // Following loop adding subject and there length of mcqs to be picked it is for computer science subjects
  //   for (var index = 0; index < computerPrecentages.length; index++) {
  //     computerSubjects.add({
  //       CategoriesName.COMPUTER_SCIENCE[index].categoryName:
  //           computerPrecentages[index]
  //     });
  //   }
  //   // Following loop adding subject and there length of mcqs to be picked it is for english subjects
  //   for (var index = 0; index < englishPrecentage.length; index++) {
  //     englishSubjects.add(
  //       {CategoriesName.ENGLISH[index].categoryName: englishPrecentage[index]},
  //     );
  //   }

  //   // Following loop picking mcqs for computer science subjects
  //   for (var element in computerSubjects) {
  //     element.forEach((key, value) {
  //       Get.find<HomeController>().getMcqsFromDataBase("Computer Science", key);
  //       int getedMcqsLength = 0;
  //       while (getedMcqsLength < value) {
  //         McqsModel randomMcqs =
  //             Get.find<HomeController>().getMcqs.randomItem();
  //         if (!computerSciencePickedMcqs.contains(randomMcqs)) {
  //           computerSciencePickedMcqs.add(randomMcqs);
  //           getedMcqsLength++;
  //         }
  //       }
  //     });
  //   }
  //   // Following loop picking mcqs for English subjects
  //   for (var element in englishSubjects) {
  //     element.forEach((key, value) {
  //       print(key);
  //       print(value);
  //       Get.find<HomeController>().getMcqsFromDataBase("English", key);
  //       int getedMcqsLength = 0;
  //       while (getedMcqsLength < value) {
  //         McqsModel randomMcqs =
  //             Get.find<HomeController>().getMcqs.randomItem();
  //         if (!englishPickedMcqs.contains(randomMcqs)) {
  //           englishPickedMcqs.add(randomMcqs);
  //           print(randomMcqs);
  //           getedMcqsLength++;
  //         }
  //       }
  //     });
  //   }
  //   int index = 0;
  //   Map<String, int> computerAndEnglishMcqsLength = {
  //     "Computer": 70,
  //     "English": 30,
  //   };
  //   computerAndEnglishMcqsLength.forEach((key, value) {
  //     int pickedMcqsIndex = 0;
  //     while (pickedMcqsIndex < value) {
  //       McqsModel? randomMcqs;
  //       if (key == "Computer") {
  //         randomMcqs = computerSciencePickedMcqs.randomItem();
  //       } else {
  //         randomMcqs = englishPickedMcqs.randomItem();
  //       }
  //       if (!selectedMcqs.contains(randomMcqs)) {
  //         selectedMcqs.add(randomMcqs);
  //         pickedMcqsIndex++;
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GetBuilder<TestController>(builder: (testController) {
          return Scaffold(
            backgroundColor: Constants.LIGHT_BLUE_COLOR,
            appBar: CustomAppBar.CUSTOM_APPBAR(
              context: context,
              title: "GAT TEST",
              leadingButtonText:
                  testController.getIsTestStart ? "Stop" : "Start",
              leadingButtonPressFunction: () async {
                if (testController.getIsTestStart) {
                  testController.setSkippedMcqs =
                      testController.getSelectedMcqs.length -
                          (testController.getObtainedMarks +
                              testController.getWrongAnswerByUser);
                  ShowToast.SHOW_TOAST(
                      "Please wait while we calculate your result.");
                  await Future.delayed(const Duration(seconds: 2));
                  testController.setIsTestStart = false;
                  testController.getTimer!.cancel();
                  Get.toNamed(Routes.getResultPage());
                } else {
                  testController.setIsTestStart = true;
                  testController.update();
                  testController.testTimer();
                }
              },
              buttonText: testController.getIsTestStart
                  ? testController.getRemainingTime
                  : Constants.FORMATE_TIME(
                      testController.getTotalTime,
                    ),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                left: constraints.maxWidth * .03,
                right: constraints.maxWidth * .03,
                // top: constraints.maxWidth * .03,
                bottom: 35,
              ),
              child: Stack(
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      // List<String> mcqsOptions = [
                      //   testController.getSelectedMcqs[index].wrongAnswer1,
                      //   testController.getSelectedMcqs[index].wrongAnswer2,
                      //   testController.getSelectedMcqs[index].wrongAnswer3,
                      //   testController.getSelectedMcqs[index].rightAnswer,
                      // ];
                      // Map<String, String> mcqsOptionWithNo = {
                      //   "A": mcqsOptions[0],
                      //   "B": mcqsOptions[1],
                      //   "C": mcqsOptions[2],
                      //   "D": mcqsOptions[3]
                      // };

                      return Container(
                        margin: index < 1
                            ? const EdgeInsets.only(top: 10)
                            : index == 99
                                ? EdgeInsets.only(
                                    top: constraints.maxWidth * .03,
                                    bottom: constraints.maxWidth * .03,
                                  )
                                : EdgeInsets.only(
                                    top: constraints.maxWidth * .03,
                                  ),
                        padding: EdgeInsets.all(
                          constraints.maxWidth * .02,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          border: Border.all(
                            color: Constants.DARK_BLUE_COLOR,
                          ),
                        ),
                        child: McqsWidget(
                          index: index,
                          constraints: constraints,
                          mcqs: testController
                              .getShuffledMcqsQuestionAnswers[index],
                          // mcqsOptionWithNo: mcqsOptionWithNo,
                        ),
                      );
                    },
                    itemCount:
                        testController.getShuffledMcqsQuestionAnswers.length,
                  ),
                  testController.getIsTestStart
                      ? SizedBox()
                      : Container(
                          width: double.infinity,
                          color: Constants.LIGHT_BLUE_COLOR.withOpacity(.9),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "Please carefully read the message: ",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    TextSpan(
                                      text:
                                          "When you click on the option inside the circle, whether intentionally or unintentionally, the question will be displayed, and the selected option will be considered your answer. If the allotted time elapses, the test will be automatically closed, and you will be redirected to the result page.\nThe test consists of 100 Mcqs, with 30 questions selected from English subjects and the remaining 70 questions selected from computer science subjects.",
                                      // style: TextStyle(color: Colors.red),
                                    ),
                                    TextSpan(
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
                                style: TextStyle(
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
            bottomSheet: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Constants.DARK_BLUE_COLOR,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Answered Mcqs: ${testController.getUserTestMcqsModel.length}",
                    style: TextStyle(
                      color: Constants.LIGHT_BLUE_COLOR,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Left MCQs: ${testController.getSelectedMcqs.length - testController.getUserTestMcqsModel.length}",
                    style: TextStyle(
                      color: Constants.LIGHT_BLUE_COLOR,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
