import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '/controllers/splash_controller.dart';
import '/pages/SubjectsPage/subjects_page.dart';
import '/pages/IntialPage/intial_page.dart';
import '/utils/constants.dart';

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
    try {
      // Future.delayed(Duration(seconds: 10));
      await Get.find<SplashController>().tryAutoLogin()
          ? Get.find<SplashController>().getIsAdmin
              ? Get.offAllNamed(
                  Routes.getUsersDetailsPage(),
                )
              : Get.offAllNamed(Routes.getHomePage())
          : Get.offAndToNamed(
              Routes.getInitialPage(),
            );
    } finally {
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return AnimatedSplashScreen.withScreenFunction(
    //     splash: SvgPicture.asset(
    //       Constants.LIGHT_BACKGROUN_LOGO_SVG,
    //       height: MediaQuery.of(context).size.height * .37,
    //     ),
    //     backgroundColor: Constants.LIGHT_BLUE_COLOR,
    //     splashIconSize: 300,
    //     pageTransitionType: PageTransitionType.bottomToTop,
    //     splashTransition: SplashTransition.scaleTransition,
    //     duration: 5000,
    //     screenFunction: () async {
    //       return const SizedBox();
    //       // if (await Get.find<SplashController>().tryAutoLogin()) {
    //       //   return Get.find<SplashController>().getIsAdmin
    //       //       ? UsersDetailsPage()
    //       //       : HomePage();
    //       // } else {
    //       //   return const InitialPage();
    //       // }
    //     });
  }
}
