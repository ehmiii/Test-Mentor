import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';
import '/models/mcqs_model.dart';
import '/pages/McqsPage/widgets/test_mcqs_selection_dialog.dart';
import '/utils/constants.dart';

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
          title: Get.find<HomeController>().getMcqs[0].category),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return Container(
          color: Constants.LIGHT_BLUE_COLOR,
          padding: const EdgeInsets.only(top: 8),
          child: ListView.builder(
            itemBuilder: (_, index) {
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
                  mcqs: homeController.getMcqs[index],
                  index: index + 1,
                ),
              );
            },
            itemCount: homeController.getMcqs.length,
          ),
        );
      }),
    );
  }
}
