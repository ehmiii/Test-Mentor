import 'package:flutter/material.dart';
import 'package:gat_cs_trainer_app/utils/constants.dart';
import 'package:gat_cs_trainer_app/utils/widgets/custom_appbar.dart';
import 'package:get/get.dart';

import '../../../controllers/admin_controller.dart';
import '../UsersDetailsPage/add_mcqs.dart';

class AdminMcqsDetailPage extends StatelessWidget {
  const AdminMcqsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: CustomAppBar.CUSTOM_APPBAR(
          context: context,
          title: "Admin Mcqs",
        ),
        backgroundColor: Constants.LIGHT_BLUE_COLOR,
        body: GetBuilder<AdminController>(
          builder: (adminController) => adminController.getIsLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : adminController.getAdminMcqs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await adminController.getAdminMcqsFromDataBase();
                            },
                            child: const Text(
                              "Refresh",
                            ),
                          ),
                          const Text("Please post some mcqs")
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: adminController.getAdminMcqs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Constants.DARK_BLUE_COLOR,
                              child: ListTileTheme(
                                horizontalTitleGap: 0,
                                contentPadding: EdgeInsets.all(0),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor:
                                            Constants.DARK_BLUE_COLOR,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Constants
                                                        .DARK_BLACK_COLOR,
                                                  ),
                                                ),
                                                child: Text(
                                                  adminController
                                                      .getAdminMcqs[index]
                                                      .category,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Constants
                                                        .LIGHT_BLUE_COLOR,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Question: ${adminController.getAdminMcqs[index].question}",
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  color: Constants
                                                      .LIGHT_BLUE_COLOR,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Wrong: ${adminController.getAdminMcqs[index].wrongAnswer1}",
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    color: Constants
                                                        .LIGHT_BLUE_COLOR,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Wrong: ${adminController.getAdminMcqs[index].wrongAnswer2}",
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    color: Constants
                                                        .LIGHT_BLUE_COLOR,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Wrong: ${adminController.getAdminMcqs[index].wrongAnswer3}",
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    color: Constants
                                                        .LIGHT_BLUE_COLOR,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Right: ${adminController.getAdminMcqs[index].rightAnswer}",
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    color: Constants
                                                        .LIGHT_BLUE_COLOR,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Constants.LIGHT_BLUE_COLOR,
                                    ),
                                    onPressed: () {
                                      Get.find<AdminController>()
                                              .getQuestionController
                                              .text =
                                          adminController
                                              .getAdminMcqs[index].question;
                                      Get.find<AdminController>()
                                              .getWrongAnswer1Controller
                                              .text =
                                          adminController
                                              .getAdminMcqs[index].wrongAnswer1;
                                      Get.find<AdminController>()
                                              .getWrongAnswer2Controller
                                              .text =
                                          adminController
                                              .getAdminMcqs[index].wrongAnswer2;
                                      Get.find<AdminController>()
                                              .getWrongAnswer3Controller
                                              .text =
                                          adminController
                                              .getAdminMcqs[index].wrongAnswer3;
                                      Get.find<AdminController>()
                                              .getRightAnswerController
                                              .text =
                                          adminController
                                              .getAdminMcqs[index].rightAnswer;
                                      Get.find<AdminController>()
                                              .setSelectedSpecialization =
                                          adminController
                                              .getAdminMcqs[index].category;

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                          backgroundColor:
                                              Constants.LIGHT_BLUE_COLOR,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ), //this right here
                                          child: AddMcqsByAdmin(
                                            mcqs: adminController
                                                .getAdminMcqs[index],
                                          ),
                                        ),
                                        // barrierDismissible: false,
                                        barrierLabel: "Review",
                                        barrierColor: Constants.DARK_BLUE_COLOR
                                            .withOpacity(.7),
                                      );
                                    },
                                  ),
                                  title: Text(
                                    "Q: ${adminController.getAdminMcqs[index].question}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Constants.LIGHT_BLUE_COLOR),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await adminController
                                          .deleteMcqsFromDataBase(
                                              adminController
                                                  .getAdminMcqs[index]);
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
        ),
      ),
    );
  }
}
