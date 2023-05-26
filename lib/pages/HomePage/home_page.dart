import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import '../../utils/widgets/show_toast.dart';
import '/controllers/home_controller.dart';
import '/utils/constants.dart';

import '../../utils/Routes/routes.dart';
import '../../utils/widgets/custom_appbar.dart';
import 'widgets/custom_card.dart';
import 'widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return GetBuilder<HomeController>(builder: (homeController) {
          return AdvancedDrawer(
            backdropColor: Constants.BLUE_COLOR,
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            // openScale: 1.0,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            drawer: CustomDrawer.CUSTOM_DRAWER(context),
            child: Scaffold(
              appBar: CustomAppBar.CUSTOM_APPBAR(
                // isLeadingBack: false,
                context: context,
                title: "Home",
                widget: Stack(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.toNamed(Routes.getNotificationPage());
                      },
                      icon: Icon(
                        Icons.notifications,
                        size: 30,
                        color: Constants.LIGHT_BLUE_COLOR,
                      ),
                    ),
                    homeController.getNotifications.isEmpty
                        ? const SizedBox()
                        : Positioned(
                            right: 12,
                            top: 7,
                            child: Icon(
                              Icons.circle,
                              color: Constants.BLUE_COLOR,
                              size: 12,
                            ),
                          ),
                  ],
                ),
                leadingButtonImage: Constants.HU_LOGO,
                leadingButtonPressFunction: homeController.getUserInfo != null
                    ? () {
                        _advancedDrawerController.showDrawer();
                      }
                    : () {},
                leadingButtonIcon:
                    homeController.getUserInfo != null ? Icons.menu : null,
              ),
              // drawer: const Drawer(),
              backgroundColor: Constants.LIGHT_BLUE_COLOR,
              body: homeController.getIsLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : homeController.getSubjectsMcqs.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: const Text("Refresh"),
                                onPressed: () async {
                                  await homeController
                                      .getAvaliableCategoriesAndNotifications();
                                  if (homeController.getUserData != null) {
                                    await homeController
                                        .getAvaliableCategoriesAndNotifications(
                                            isGettingNotifications: true);
                                  }
                                },
                              ),
                              const Text(
                                  "No mcqs Founded click refresh button again")
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                flex:
                                    homeController.getUserInfo == null ? 3 : 1,
                                child: Container()),
                            homeController.getUserInfo == null
                                ? const SizedBox()
                                : ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        Routes.getAddMcqsPage(),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Add Mcqs",
                                        style: TextStyle(
                                          color: Constants.LIGHT_BLUE_COLOR,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                            Get.find<HomeController>().getUserInfo == null
                                ? const SizedBox()
                                : Flexible(flex: 1, child: Container()),

                            // Container(
                            //   height: 100,
                            //   width: 100,
                            //   constraints: BoxConstraints(
                            //     maxHeight: 100,
                            //     maxWidth: 100,
                            //     minHeight: 100,
                            //     minWidth: 100,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //   ),
                            //   child: ClipOval(
                            //     child: CachedNetworkImage(
                            //       imageUrl: homeController.getUserInfo!.profileImageUrl,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            CustomCard(
                              cardTitle: "Test Preparation Area",
                              icon: Constants.PREPARATION_MODE_ICON,
                              press: () async {
                                homeController.setUserChoice = "Preparation";
                                Get.toNamed(Routes.getSubjectsSelection());
                                // if (homeController.errorMessage == "Done") {
                                // homeController.setUserChoice = "Preparation";
                                // } else {
                                //   ShowToast.SHOW_TOAST(homeController.errorMessage == ""
                                //       ? "Apologies for the error on your side. Please refresh or restart and contact support if the issue persists. Thank you."
                                //       : homeController.errorMessage);
                                //   if (homeController.getMcqs.isEmpty) {
                                //     await homeController
                                //         .getAvaliableCategoriesAndNotifications();
                                //   }
                                // }
                              },
                            ),
                            CustomCard(
                              cardTitle: "Subject-wise Quiz Area",
                              icon: Constants.TESS_MODE_ICON,
                              press: () {
                                if (homeController.getMcqs.isEmpty) {
                                  homeController
                                      .getAvaliableCategoriesAndNotifications();
                                }
                                homeController.setUserChoice = "Test";
                                Get.toNamed(Routes.getSubjectsSelection());
                              },
                            ),
                            CustomCard(
                              cardTitle: "GAT Test Simulation",
                              icon: Constants.TESS_MODE_ICON,
                              press: () {
                                homeController.setUserChoice = "GATTest";
                                Get.toNamed(Routes.getGatTestSimulationPage());
                              },
                            ),
                            CustomCard(
                              cardTitle: "View Test History",
                              builtInIcon: Icons.history,
                              press: () {
                                homeController.setUserChoice = "Test History";
                                Get.toNamed(Routes.getTestHistoryPage());
                              },
                            ),
                            CustomCard(
                              cardTitle: "About Us",
                              builtInIcon: Icons.info,
                              press: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  headerAnimationLoop: false,
                                  barrierColor:
                                      Constants.BLUE_COLOR.withOpacity(.7),
                                  dialogBackgroundColor:
                                      Constants.DARK_BLUE_COLOR,
                                  customHeader: Image.asset(
                                    Constants.HU_LOGO,
                                    fit: BoxFit.fill,
                                  ),
                                  title: "About us",
                                  body: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "GAT(CS) Trainer: Developed by Hazara University students Ahmad Khan and Hamza Sher, our app offers comprehensive preparation for the Graduate Assessment Test (Computer Science). Access practice questions, study materials, and mock exams to excel in the GAT(CS). Free to download and user-friendly, we're here to support your academic success.",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  btnCancelOnPress: () {
                                    Get.back();
                                  },
                                  autoDismiss: false,
                                  onDismissCallback: (value) {},
                                ).show();
                              },
                            ),
                            Flexible(
                              flex: 3,
                              child: Container(),
                            ),
                            homeController.getUserInfo == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Specialist?",
                                        style: TextStyle(
                                            // color: Constants.DARK_BLUE_COLOR,
                                            ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.offAllNamed(
                                            Routes.getSignInPage(),
                                          );
                                        },
                                        child: const Text(
                                          "SignIn",
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
              floatingActionButton:
                  Get.find<HomeController>().getUserInfo == null
                      ? null
                      : FloatingActionButton(
                          onPressed: () {
                            Get.toNamed(
                              Routes.getAddMcqsPage(),
                            );
                          },
                          splashColor: Constants.LIGHT_BLUE_COLOR,
                          backgroundColor: Constants.DARK_BLUE_COLOR,
                          tooltip: "Add New Mcqs",
                          child: Icon(
                            Icons.add,
                            color: Constants.LIGHT_BLUE_COLOR,
                            size: 35,
                          ),
                        ),
            ),
          );
        });
      },
    );
  }
}
