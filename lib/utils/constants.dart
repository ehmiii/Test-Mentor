// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Constants {
  // App Color scheme
  static Color LIGHT_BLUE_COLOR = const Color(0xFFC2E6F4);
  static Color DARK_BLUE_COLOR = const Color(0xFF0A3859);
  static Color DARK_BLACK_COLOR = const Color(0xFF0B2025);
  static Color DARK_GRAY_COLOR = const Color(0xFF1A535B);
  static Color BLUE_COLOR = const Color(0xFF2F9BA6);

  // App Material Colors Scheme
  static MaterialColor DARK_BLUE_COLOR_MATERIAL_COLOR =
      MaterialColor(0xFF0A3859, {
    50: Constants.DARK_BLUE_COLOR.withOpacity(.1),
    100: Constants.DARK_BLUE_COLOR.withOpacity(.2),
    200: Constants.DARK_BLUE_COLOR.withOpacity(.3),
    300: Constants.DARK_BLUE_COLOR.withOpacity(.4),
    400: Constants.DARK_BLUE_COLOR.withOpacity(.5),
    500: Constants.DARK_BLUE_COLOR.withOpacity(.6),
    600: Constants.DARK_BLUE_COLOR.withOpacity(.7),
    700: Constants.DARK_BLUE_COLOR.withOpacity(.8),
    800: Constants.DARK_BLUE_COLOR.withOpacity(.9),
    900: Constants.DARK_BLUE_COLOR.withOpacity(1),
  });

  // Logos Path
  // static String DARK_BACKGROUN_LOGO =
  //     "assets/images/forDarkBlueBackgroundLogo.png";
  // static String LIGHT_BACKGROUN_LOGO =
  //     "assets/images/forLightBlueBackgroundLogo.png";
  static String DARK_BACKGROUN_LOGO_SVG = "assets/images/ForDarkBackground.svg";
  static String LIGHT_BACKGROUN_LOGO_SVG =
      "assets/images/ForLightBackground.svg";
  static String DARK_BACKGROUN_LOGO_GIF = "assets/images/ForDarkBackground.gif";
  static String LIGHT_BACKGROUN_LOGO_GIF =
      "assets/images/ForLightBackground.gif";
  static String HU_LOGO = 'assets/images/hu_logo.png';
  // Image Icons path
  static String BACK_ICON = "assets/icons/back_icon.png";
  static String CLOSE_ICON = "assets/icons/close_icon.png";
  static String MCQS_FORWARD_ICON = "assets/icons/mcqs_forward_icon.png";
  static String RETEST_ICON = "assets/icons/retest_icon.png";
  static String TEST_REVIEW_ICON = "assets/icons/test_review_icon.png";
  static String SKIP_ICON = "assets/icons/skip_icon.png";
  static String GUIDELINE_ICON = "assets/icons/guide_line_icon.png";
  static String AUTHENTICATION_BACK_BUTTON =
      "assets/icons/authentication_back_button.png";
  static String LOGIN_AND_SIGNUP_BUTTON =
      "assets/icons/login_and_signup_button.png";
  static String PROFILE_IMAGE = 'assets/images/profile_image.png';
  static String CHECK_MARK = 'assets/icons/accept_icon.png';
  static String REJECT_ICON = 'assets/icons/reject_icon.png';
  static String PDF_ICON = 'assets/icons/pdf_icon.png';
  static String PREPARATION_MODE_ICON =
      "assets/icons/preparation_mode_icon.png";
  static String TESS_MODE_ICON = "assets/icons/test_mode.png";

  //Colors List
  static List<Color> APP_COLORS = [
    Constants.BLUE_COLOR,
    Constants.DARK_BLACK_COLOR,
    Constants.DARK_BLUE_COLOR,
    Constants.DARK_GRAY_COLOR,
    Colors.white
  ];

  // Time formator
  static String FORMATE_TIME(int timeInSeconds) {
    return "${timeInSeconds ~/ 60 < 10 ? 0 : ""}${timeInSeconds ~/ 60}:${(timeInSeconds % 60 == 0) ? "00" : timeInSeconds % 60 < 10 ? "0${timeInSeconds % 60}" : "${timeInSeconds % 60}"} min";
  }
}
