import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:testmentor/controllers/home_controller.dart';
import 'package:testmentor/models/mcqs_model.dart';
import 'package:testmentor/pages/McqsPage/widgets/test_mcqs_selection_dialog.dart';
import 'package:testmentor/utils/constants.dart';

import '../../utils/widgets/custom_appbar.dart';
import 'widgets/mcqs.dart';

class McqsPage extends StatelessWidget {
  McqsPage({super.key});
  // List<Widget> mcqsList = [
  //   Mcqs(
  //     question: "Who you are?",
  //     wrongAnswer1: "Animal",
  //     wrongAnswer2: "Food",
  //     wrongAnswer3: "Trees",
  //     rightAnswer: "Human",
  //   ),
  //   Mcqs(
  //     question: "Who is the founder of Pakistan?",
  //     rightAnswer: "Muhammad Ali jannah",
  //     wrongAnswer2: "Alam Iqbal",
  //     wrongAnswer3: "Nawaz Sharif",
  //     wrongAnswer1: "Maryam Nawaz Safdar",
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.CUSTOM_APPBAR(
        context: context,
        buttonText: "Start Test",
        buttonPressFunction: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                TestMcqsSelectionDialog.TEST_MCQS_SELECTION_DIALOG(context),
            barrierDismissible: false,
            barrierLabel: "Select Length of Mcqs",
            barrierColor: Constants.DARK_BLUE_COLOR.withOpacity(.7),
          );
        },
      ),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return RefreshIndicator(
          onRefresh: () => homeController
              .getMcqsFromDataBase(homeController.getSelectedCategory),
          child: Container(
            color: Constants.LIGHT_BLUE_COLOR,
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              itemBuilder: (_, index) {
                McqsModel mcqs = homeController.getMcqs[index];
                return Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 8,
                    right: 8,
                    left: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        Constants.BLUE_COLOR,
                        Constants.LIGHT_BLUE_COLOR,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          .5,
                        ),
                        offset: const Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Mcqs(
                    question: mcqs.question,
                    rightAnswer: mcqs.rightAnswer,
                    wrongAnswer1: mcqs.wrongAnswer1,
                    wrongAnswer2: mcqs.wrongAnswer2,
                    wrongAnswer3: mcqs.wrongAnswer3,
                  ),
                );
              },
              itemCount: homeController.getMcqs.length,
            ),
          ),
        );
      }),
    );
  }
}
