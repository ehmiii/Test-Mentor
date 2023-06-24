import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/controllers/home_controller.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/bottom_sheet_camera_and_gallery.dart';
import '../../utils/widgets/custom_appbar.dart';
import '../../utils/widgets/show_toast.dart';
import 'widgets/edit_button.dart';
import 'widgets/mcqs_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().setIsEditingEnable = false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        appBar: CustomAppBar.CUSTOM_APPBAR(
          context: context,
          title: "Profile",
          buttonText: homeController.getIsEditingEnable ? "Save" : "Edit",
          buttonPressFunction: homeController.getIsLoading
              ? null
              : () async {
                  if (homeController.getUserNameController.text.isNotEmpty) {
                    await homeController.updateUserData();
                    homeController.setIsEditingEnable =
                        !homeController.getIsEditingEnable;
                    homeController.update();
                  } else {
                    ShowToast.SHOW_TOAST("Please Enter your Name");
                  }
                },
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          return Container(
            width: constrains.maxWidth,
            color: Constants.LIGHT_BLUE_COLOR,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(constrains.maxWidth * .02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: constrains.maxHeight * .15,
                                  maxWidth: constrains.maxHeight * .15,
                                  minHeight: constrains.maxHeight * .15,
                                  minWidth: constrains.maxHeight * .15,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constants.LIGHT_BLUE_COLOR,
                                ),
                                child: ClipOval(
                                  child: homeController.getPickedImage != ""
                                      ? Image.file(
                                          File(homeController.getPickedImage),
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: homeController
                                              .getUserInfo!.profileImageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              homeController.getIsEditingEnable
                                  ? Positioned(
                                      bottom: -2,
                                      right: -2,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                            BottomSheetCameraAndGallery(
                                              cameraFuction: () {
                                                Get.back();
                                                homeController.getImage(
                                                    ImageSource.camera);
                                              },
                                              galleryFuction: () {
                                                Get.back();
                                                homeController.getImage(
                                                    ImageSource.gallery);
                                              },
                                            ),
                                            backgroundColor:
                                                Constants.LIGHT_BLUE_COLOR,
                                          );
                                        },
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Constants.DARK_BLACK_COLOR,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "Full Name",
                        style: TextStyle(
                          color: Constants.DARK_BLACK_COLOR,
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: constrains.maxWidth * .02,
                        ),
                        height: constrains.maxHeight * .09,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Constants.DARK_BLUE_COLOR,
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        child: TextFormField(
                          controller: homeController.getUserNameController,
                          style: TextStyle(
                            color: Constants.LIGHT_BLUE_COLOR,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            enabled: homeController.getIsEditingEnable,
                            contentPadding:
                                EdgeInsets.all(constrains.maxWidth * .03),
                            // hintStyle:
                            border: InputBorder.none,
                          ),
                          cursorColor: Constants.LIGHT_BLUE_COLOR,
                        ),
                      ),
                      SizedBox(
                        height: constrains.maxWidth * 0.03,
                      ),
                      Text(
                        "Specialization",
                        style: TextStyle(
                          color: Constants.DARK_BLACK_COLOR,
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: constrains.maxWidth * .02,
                        ),
                        height: constrains.maxHeight * .09,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Constants.DARK_BLUE_COLOR,
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          // style: TextStyle(),
                          decoration: InputDecoration(
                            enabled: false,
                            contentPadding:
                                EdgeInsets.all(constrains.maxWidth * .03),
                            hintText:
                                homeController.getUserInfo!.specialization[0],
                            hintStyle: TextStyle(
                              color: Constants.LIGHT_BLUE_COLOR,
                              fontSize: 20,
                            ),
                            border: InputBorder.none,
                          ),
                          cursorColor: Constants.LIGHT_BLUE_COLOR,
                        ),
                      ),
                      SizedBox(
                        height: constrains.maxWidth * 0.03,
                      ),
                      McqsSection(
                        constrains: constrains,
                      ),
                    ],
                  ),
                ),
                EditButton(
                  constrains: constrains,
                )
              ],
            ),
          );
        }),
      );
    });
  }
}
