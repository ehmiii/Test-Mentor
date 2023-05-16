import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '/controllers/add_mcqs_controller.dart';
import '/utils/constants.dart';
import '/utils/widgets/custom_appbar.dart';

import '../../controllers/home_controller.dart';
import '../../utils/Routes/routes.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.CUSTOM_APPBAR(
        context: context,
        title: "Notifications",
      ),
      backgroundColor: Constants.LIGHT_BLUE_COLOR,
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          return homeController.getIsLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView.builder(
                  itemCount: homeController.getNotifications.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Slidable(
                      // direction: Axis.horizontal,
                      // enabled: true,
                      endActionPane: ActionPane(
                        extentRatio: .15,
                        motion: const ScrollMotion(),
                        children: [
                          IconButton(
                            onPressed: () async {
                              await homeController.deleteNotification(
                                  homeController.getNotifications[index]);
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      child: Card(
                          color: Constants.DARK_BLUE_COLOR,
                          child: ExpansionTileTheme(
                            data: ExpansionTileThemeData(
                              iconColor: Constants.LIGHT_BLUE_COLOR,
                              collapsedIconColor: Constants.LIGHT_BLUE_COLOR,
                              collapsedTextColor: Constants.LIGHT_BLUE_COLOR,
                              textColor: Constants.LIGHT_BLUE_COLOR,
                            ),
                            child: ExpansionTile(
                              title: Text(
                                homeController.getNotifications[index]
                                        .rejectionMessage ??
                                    "Message not found",
                              ),
                              leading: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                ),
                                onPressed: () {
                                  Get.offAndToNamed(
                                    Routes.getAddMcqsPage(),
                                    arguments: [
                                      homeController.getNotifications[index],
                                      true
                                    ],
                                  );
                                },
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subject: ${homeController.getNotifications[index].category}",
                                  style: TextStyle(
                                    color: Constants.LIGHT_BLUE_COLOR,
                                  ),
                                ),
                                Text(
                                  "Question: ${homeController.getNotifications[index].question}",
                                  style: TextStyle(
                                    color: Constants.LIGHT_BLUE_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          )
                          // child: ListTile(
                          //   leading: IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.edit,
                          //       color: Constants.DARK_BLUE_COLOR,
                          //     ),
                          //   ),
                          //   title: ,
                          // ),
                          ),
                    );
                  },
                );
        },
      ),
    );
  }
}
