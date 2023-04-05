import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmentor/controllers/admin_controller.dart';

import '../../../utils/Routes/routes.dart';
import '../../../utils/constants.dart';

class UsersDetailsPage extends StatelessWidget {
  AdminController adminController = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin",
          style: TextStyle(color: Constants.LIGHT_BLUE_COLOR),
        ),
        centerTitle: true,
        leading: TextButton(
          child: FittedBox(
            child: Text(
              "Logout",
              style: TextStyle(
                color: Constants.LIGHT_BLUE_COLOR,
              ),
            ),
          ),
          onPressed: () {
            adminController.logoutUser().then(
                  (_) => Get.offAllNamed(
                    Routes.getInitialPage(),
                  ),
                );
          },
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.getAdminNewMcqsPage());
                    },
                    child: Icon(
                      Icons.notifications,
                      size: 25,
                      color: Constants.LIGHT_BLUE_COLOR,
                    ),
                  ),
                  GetBuilder<AdminController>(
                    builder: (admin) => adminController.getPendingMcqs.isEmpty
                        ? const SizedBox()
                        : Positioned(
                            right: 2,
                            top: 2,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Constants.BLUE_COLOR,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<AdminController>(builder: (adminController) {
        return Container(
          color: Constants.LIGHT_BLUE_COLOR,
          child: adminController.getIsLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : RefreshIndicator(
                  onRefresh: () => adminController.getUsersDetials(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 80,
                              margin: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Constants.BLUE_COLOR,
                                    Constants.LIGHT_BLUE_COLOR,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    color: Constants.DARK_BLUE_COLOR
                                        .withOpacity(.5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: adminController
                                              .getusers[index].profileImageUrl,
                                          placeholder: ((context, url) =>
                                              const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              )),
                                          errorWidget: (context, url, error) =>
                                              ClipOval(
                                            child: Image.asset(
                                              Constants.PROFILE_IMAGE,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        adminController
                                            .getusers[index].userName,
                                        style: TextStyle(
                                          color: Constants.DARK_BLUE_COLOR,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        adminController.getusers[index].email,
                                        style: TextStyle(
                                          color: Constants.DARK_BLUE_COLOR,
                                        ),
                                      )
                                    ],
                                  ),
                                  Flexible(child: Container(), flex: 1),
                                  adminController.getusers[index].isAdmin!
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Admin",
                                            style: TextStyle(
                                              color: Constants.DARK_BLUE_COLOR,
                                              fontSize: 18,
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Mcqs",
                                            style: TextStyle(
                                              color: Constants.DARK_BLUE_COLOR,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: adminController.getusers.length,
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
