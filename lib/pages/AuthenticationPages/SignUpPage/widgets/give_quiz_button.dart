import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../../controllers/signup_controller.dart';
import '../../../../utils/constants.dart';

class GiveQuizButton extends StatelessWidget {
  const GiveQuizButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(
            15,
          ),
          topRight: Radius.circular(
            15,
          ),
        ),
        gradient: LinearGradient(
          colors: [
            Constants.BLUE_COLOR,
            Constants.LIGHT_BLUE_COLOR,
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(
            15,
          ),
          topRight: Radius.circular(
            15,
          ),
        ),
        child: InkWell(
          onTap: () {
            Get.find<SignUpController>().setIsQuizPassed =
                !Get.find<SignUpController>().getIsQuizPassed;
          },
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(
              15,
            ),
            topRight: Radius.circular(
              15,
            ),
          ),
          splashColor: Constants.DARK_BLUE_COLOR,
          child: Container(
            padding: const EdgeInsets.all(13),
            child: Text(
              "Give Quiz",
              style: TextStyle(
                fontSize: 20,
                color: Constants.DARK_BLUE_COLOR,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
