import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:testmentor/controllers/admin_controller.dart';

import '../../../utils/constants.dart';
import '../../../utils/widgets/show_toast.dart';

class AdminNewMcqsPage extends StatelessWidget {
  AdminNewMcqsPage({super.key});
  final List<String> options = ["A)", "B)", "C)", "D)"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Constants.LIGHT_BLUE_COLOR,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  Get.find<AdminController>().setIsLoading = true;
                  Get.find<AdminController>().update();
                  await Get.find<AdminController>()
                      .getPendingMcqsFromDataBase();
                } catch (error) {
                  if (error.toString().contains('Nothing')) {
                    ShowToast.SHOW_TOAST("No new notificaiton");
                  } else if (error.toString().contains("Failed host lookup")) {
                    ShowToast.SHOW_TOAST(
                        "Make sure you have internet connection");
                  }
                } finally {
                  Get.find<AdminController>().setIsLoading = false;
                  Get.find<AdminController>().update();
                }
              },
              icon: Icon(
                Icons.replay_sharp,
                color: Constants.LIGHT_BLUE_COLOR,
              ))
        ],
      ),
      body: Container(
        color: Constants.LIGHT_BLUE_COLOR,
        child: GetBuilder<AdminController>(builder: (adminController) {
          return RefreshIndicator(
            onRefresh: () => adminController.getPendingMcqsFromDataBase(),
            child: adminController.getPendingMcqs.isEmpty
                ? adminController.getIsLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No notification",
                              style: TextStyle(
                                color: Constants.DARK_BLUE_COLOR,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      )
                : ListView.builder(
                    // shrinkWrap: true,
                    itemCount: adminController.getPendingMcqs.length,
                    itemBuilder: (_, pendingindex) {
                      List<String> answers = [
                        adminController
                            .getPendingMcqs[pendingindex].wrongAnswer1,
                        adminController
                            .getPendingMcqs[pendingindex].wrongAnswer2,
                        adminController
                            .getPendingMcqs[pendingindex].wrongAnswer3,
                        adminController
                            .getPendingMcqs[pendingindex].rightAnswer,
                      ];
                      answers.shuffle();
                      return adminController.getIsLoading
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : Container(
                              margin: const EdgeInsets.all(
                                8,
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  const BoxShadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 2,
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Constants.BLUE_COLOR,
                                    Constants.LIGHT_BLUE_COLOR,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Category: ${adminController.getPendingMcqs[pendingindex].category}",
                                          style: TextStyle(
                                            color: Constants.DARK_BLUE_COLOR,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      "${pendingindex + 1}. ${adminController.getPendingMcqs[pendingindex].question}",
                                      style: TextStyle(
                                        color: Constants.DARK_BLUE_COLOR,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (_, index) {
                                              return answers[index] ==
                                                      adminController
                                                          .getPendingMcqs[
                                                              pendingindex]
                                                          .rightAnswer
                                                  ? Row(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        FittedBox(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Constants
                                                                    .DARK_BLUE_COLOR,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                "${options[index]} ${answers[index]}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Constants
                                                                      .DARK_BLUE_COLOR,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        // const SizedBox(
                                                        //   width: 4,
                                                        // ),
                                                        // Expanded(
                                                        //   child: Icon(
                                                        //     Icons.check_circle_outline,
                                                        //     color: Constants.LIGHT_BLUE_COLOR,
                                                        //   ),
                                                        // ),
                                                        Flexible(
                                                          flex: 2,
                                                          child: Container(),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      "${options[index]} ${answers[index]}",
                                                      style: TextStyle(
                                                        color: Constants
                                                            .DARK_BLUE_COLOR,
                                                      ),
                                                    );
                                            },
                                            itemCount: 4,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                    Constants.CHECK_MARK,
                                                  ),
                                                  Material(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      splashColor: Constants
                                                          .DARK_BLUE_COLOR,
                                                      onTap: () async {
                                                        await adminController
                                                            .aprroveMcqs(
                                                          pendingindex,
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                    Constants.REJECT_ICON,
                                                  ),
                                                  Material(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      splashColor: Colors.red,
                                                      onTap: () {},
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 30,
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            "By: ${adminController.getPendingMcqs[pendingindex].uploaderName}",
                                            style: TextStyle(
                                              color: Constants.DARK_BLUE_COLOR,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
          );
        }),
      ),
    );
  }
}
