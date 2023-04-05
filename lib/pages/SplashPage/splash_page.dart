import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testmentor/controllers/splash_controller.dart';
import 'package:testmentor/pages/HomePage/home_page.dart';
import 'package:testmentor/pages/IntialPage/intial_page.dart';
import 'package:testmentor/utils/constants.dart';

import '../../utils/Routes/routes.dart';
import '../AdminPages/UsersDetailsPage/users_details_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    gotoNextScreen();
    super.initState();
  }

  Future<void> gotoNextScreen() async {
    Future.delayed(
      Duration(seconds: 2),
    ).then(
      (_) async => await Get.find<SplashController>().tryAutoLogin()
          ? Get.find<SplashController>().getIsAdmin
              ? Get.offAllNamed(
                  Routes.getUsersDetailsPage(),
                )
              : Get.offAllNamed(Routes.getHomePage())
          : Get.offAndToNamed(
              Routes.getInitialPage(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
        splash: Constants.LIGHT_BACKGROUN_LOGO,
        backgroundColor: Constants.LIGHT_BLUE_COLOR,
        splashIconSize: 300,
        pageTransitionType: PageTransitionType.bottomToTop,
        splashTransition: SplashTransition.scaleTransition,
        duration: 5000,
        screenFunction: () async {
          return const SizedBox();
          // if (await Get.find<SplashController>().tryAutoLogin()) {
          //   return Get.find<SplashController>().getIsAdmin
          //       ? UsersDetailsPage()
          //       : HomePage();
          // } else {
          //   return const InitialPage();
          // }
        });
  }
}
