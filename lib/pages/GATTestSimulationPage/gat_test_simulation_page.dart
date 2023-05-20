import 'package:flutter/material.dart';
import 'package:gat_cs_trainer_app/controllers/home_controller.dart';
import 'package:gat_cs_trainer_app/models/mcqs_model.dart';
import 'package:gat_cs_trainer_app/models/subjects_model.dart';
import 'package:gat_cs_trainer_app/utils/constants.dart';
import 'package:gat_cs_trainer_app/utils/data/categories_names.dart';
import 'package:gat_cs_trainer_app/utils/extensions/random_list_generation_extension.dart';
import 'package:gat_cs_trainer_app/utils/widgets/custom_appbar.dart';
import 'package:get/get.dart';

import 'widgets/mcqs.dart';

class GatTestSimulationPage extends StatelessWidget {
  const GatTestSimulationPage({super.key});
  void getSelectedMcqs() {
    List<int> precentages = [
      10,
      7,
      4,
      4,
      6,
      9,
      7,
      6,
      5,
      5,
      5,
      5,
      6,
      6,
      5,
      5,
      5,
    ];
    List<Map<String, int>> precentageOfSubject = [];
    List<McqsModel> selectedMcqs = [];
    for (var index = 0; index < precentages.length; index++) {
      precentageOfSubject.add({
        CategoriesName.COMPUTER_SCIENCE[index].categoryName: precentages[index]
      });
    }

    for (var element in precentageOfSubject) {
      element.forEach((key, value) {
        Get.find<HomeController>().getMcqsFromDataBase("Computer Science", key);
        for (var index = 0; index < value; index++) {
          selectedMcqs.add(Get.find<HomeController>().getMcqs.randomItem());
        }
      });
    }
    selectedMcqs.forEach(
      (element) {
        print(element.question);
      },
    );
    // List<SubjectsModel> totalSubjects =
    //     Get.find<HomeController>().getSubjectsMcqs;
    // for (var subject in totalSubjects) {
    //   for (var subsubject in subject.subSubjects) {
    //     print(subsubject.mcqs.length);
    //     for (var mcqs in subsubject.mcqs) {
    //       print(mcqs.question);
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    getSelectedMcqs();
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Constants.LIGHT_BLUE_COLOR,
        appBar: CustomAppBar.CUSTOM_APPBAR(
          context: context,
          title: Get.find<HomeController>().getUserChoice,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * .03,
          ),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: index < 1
                    ? EdgeInsets.zero
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
                ),
              );
            },
            itemCount: 100,
          ),
        ),
      );
    });
  }
}
