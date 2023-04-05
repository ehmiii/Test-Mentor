import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/signup_controller.dart';
import '../../../../utils/constants.dart';

class ProfileViewAndUploadButton extends StatelessWidget {
  const ProfileViewAndUploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => Get.find<SignUpController>().getPickedImage == ""
              ? Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Constants.LIGHT_BLUE_COLOR,
                    ),
                    shape: BoxShape.circle,
                  ),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                    File(
                      Get.find<SignUpController>().getPickedImage,
                    ),
                    // fit: BoxFit.fill,
                  ),
                ),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Stack(
            children: [
              Icon(
                Icons.add_a_photo,
                color: Constants.LIGHT_BLUE_COLOR,
              ),
              SizedBox(
                width: 25,
                height: 25,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Constants.DARK_BLUE_COLOR,
                    onTap: () {
                      Get.bottomSheet(
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.find<SignUpController>().uploadImage(
                                    ImageSource.camera,
                                  );
                                  Get.back();
                                },
                                child: const Text(
                                  "Camera",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.find<SignUpController>().uploadImage(
                                    ImageSource.gallery,
                                  );
                                },
                                child: const Text(
                                  "Gallery",
                                ),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: Constants.LIGHT_BLUE_COLOR,
                      );
                      // Get.find<SignUpController>().uploadImage(imageSource)
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
