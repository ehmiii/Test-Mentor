import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmentor/pages/AuthenticationPages/SignInPage/sign_in_page.dart';
import 'package:testmentor/utils/Routes/routes.dart';

import '../../../utils/constants.dart';
import '../../HomePage/home_page.dart';
import '../../ProfilePage/profile_page.dart';

class MyButton extends StatelessWidget {
  final bool isSudentbtn;
  final BoxConstraints constrains;
  // final VoidCallback press;
  const MyButton({
    super.key,
    required this.isSudentbtn,
    required this.constrains,
    // required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(1, 4),
            // blurStyle: BlurStyle.inner,
            // spreadRadius: 4,
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: isSudentbtn
            ? Constants.LIGHT_BLUE_COLOR
            : Constants.DARK_BLUE_COLOR,
        child: InkWell(
            splashColor: isSudentbtn
                ? Constants.DARK_BLUE_COLOR
                : Constants.LIGHT_BLUE_COLOR,
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              isSudentbtn
                  ? Get.toNamed(Routes.getHomePage())
                  : Get.offAllNamed(Routes.getSignInPage());
            },
            child: Container(
              alignment: Alignment.center,
              width: constrains.maxWidth * .4,
              height: constrains.maxHeight * .07,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                isSudentbtn ? "Student" : "Specialist",
                style: TextStyle(
                  color: isSudentbtn
                      ? Constants.DARK_BLACK_COLOR
                      : Constants.LIGHT_BLUE_COLOR,
                  fontSize: 20,
                ),
              ),
            )),
      ),
    );
  }
}
