import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';
import '/utils/widgets/show_toast.dart';

import '../../../utils/constants.dart';
import '../../ResultPage/result_page.dart';

class EditButton extends StatelessWidget {
  final BoxConstraints constrains;
  const EditButton({
    super.key,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Positioned(
        bottom: 0,
        child: GestureDetector(
          onTap: () async {
            if (homeController.getUserNameController.text.isNotEmpty) {
              await homeController.updateUserData();
              homeController.setIsEditingEnable =
                  !homeController.getIsEditingEnable;
              homeController.update();
            } else {
              ShowToast.SHOW_TOAST("Please Enter your Name");
            }
          },
          child: ClipPath(
            clipper: OvalTopBorderClipper(),
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              alignment: Alignment.center,
              width: constrains.maxWidth,
              height: constrains.maxHeight * 0.1,
              decoration: BoxDecoration(
                color: Constants.DARK_BLUE_COLOR,
              ),
              child: homeController.getIsLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(
                      homeController.getIsEditingEnable ? "Save" : "Edit",
                      style: TextStyle(
                        fontSize: 20,
                        color: Constants.LIGHT_BLUE_COLOR,
                      ),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
