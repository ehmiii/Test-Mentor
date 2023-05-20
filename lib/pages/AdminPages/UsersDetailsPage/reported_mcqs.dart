import 'package:flutter/material.dart';
import 'package:gat_cs_trainer_app/controllers/admin_controller.dart';
import 'package:get/get.dart';

import '../../../models/mcqs_model.dart';
import '../../../utils/constants.dart';
import 'add_mcqs.dart';

class ReportedMcqs extends StatelessWidget {
  List<McqsModel> mcqsList; // List of reported mcqs
  ReportedMcqs({
    super.key,
    required this.mcqsList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: mcqsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ExpansionTile(
              title: Text(
                "Question: ${mcqsList[index].question}",
                style: TextStyle(
                  color: Constants.DARK_BLUE_COLOR,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  Get.find<AdminController>().getQuestionController.text =
                      mcqsList[index].question;
                  Get.find<AdminController>().getWrongAnswer1Controller.text =
                      mcqsList[index].wrongAnswer1;
                  Get.find<AdminController>().getWrongAnswer2Controller.text =
                      mcqsList[index].wrongAnswer2;
                  Get.find<AdminController>().getWrongAnswer3Controller.text =
                      mcqsList[index].wrongAnswer3;
                  Get.find<AdminController>().getRightAnswerController.text =
                      mcqsList[index].rightAnswer;
                  Get.find<AdminController>().setSelectedSpecialization =
                      mcqsList[index].category;

                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      backgroundColor: Constants.LIGHT_BLUE_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ), //this right here
                      child: AddMcqsByAdmin(
                        mcqs: mcqsList[index],
                      ),
                    ),
                    // barrierDismissible: false,
                    barrierLabel: "Review",
                    barrierColor: Constants.DARK_BLUE_COLOR.withOpacity(.7),
                  );
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Comment:${mcqsList[index].rejectionMessage ?? "Message not found"}",
                  style: TextStyle(
                    color: Constants.DARK_BLUE_COLOR,
                  ),
                ),
                Text(
                  "Subject: ${mcqsList[index].category}",
                  style: TextStyle(
                    color: Constants.DARK_BLUE_COLOR,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
