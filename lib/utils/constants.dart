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
  static String DARK_BACKGROUN_LOGO =
      "assets/images/forDarkBlueBackgroundLogo.png";
  static String LIGHT_BACKGROUN_LOGO =
      "assets/images/forLightBlueBackgroundLogo.png";
  // Image Icons path
  static String BACK_ICON = "assets/images/back_icon.png";
  static String CLOSE_ICON = "assets/images/close_icon.png";
  static String MCQS_FORWARD_ICON = "assets/images/mcqs_forward_icon.png";
  static String RETEST_ICON = "assets/images/retest_icon.png";
  static String TEST_REVIEW_ICON = "assets/images/test_review_icon.png";
  static String SKIP_ICON = "assets/images/skip_icon.png";

  //Colors List
  static List<Color> APP_COLORS = [
    Constants.BLUE_COLOR,
    Constants.DARK_BLACK_COLOR,
    Constants.DARK_BLUE_COLOR,
    Constants.DARK_GRAY_COLOR,
    Colors.white
  ];

  // Custom AppBar
  static PreferredSizeWidget CUSTOM_APPBAR({
    required BuildContext context,
    String? title,
    String? buttonText,
    IconData? icon,
    VoidCallback? buttonPressFunction,
    VoidCallback? leadingButtonPressFunction,
    IconData? leadingButtonIcon,
    bool isLeadingBack = true,
    String? leadingButtonText,
  }) {
    return AppBar(
      leading: isLeadingBack || leadingButtonText != null
          ? Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                ),
                gradient: LinearGradient(
                  colors: [
                    Constants.BLUE_COLOR,
                    Constants.BLUE_COLOR.withOpacity(.3),
                    Colors.transparent,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                  ),
                  splashColor: Constants.LIGHT_BLUE_COLOR,
                  onTap: leadingButtonPressFunction ??
                      () {
                        Navigator.maybePop(context);
                      },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Constants.BLUE_COLOR,
                          // Constants.BLUE_COLOR.withOpacity(.3),
                          Colors.transparent,
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    child: leadingButtonIcon != null
                        ? Icon(
                            leadingButtonIcon,
                            size: 35,
                            color: Constants.LIGHT_BLUE_COLOR,
                          )
                        : leadingButtonText != null
                            ? FittedBox(
                                child: Text(
                                  leadingButtonText,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Constants.LIGHT_BLUE_COLOR,
                                  ),
                                ),
                              )
                            : Image.asset(
                                Constants.BACK_ICON,
                              ),
                  ),
                ),
              ),
            )
          : Builder(
              builder: (ctx) => IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 40,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
      title: Text(
        title ?? "",
        style: TextStyle(
          color: Constants.LIGHT_BLUE_COLOR,
          fontSize: 25,
        ),
      ),
      centerTitle: true,
      actions: [
        buttonText == null && icon == null
            ? const SizedBox()
            : Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Constants.BLUE_COLOR,
                      Constants.BLUE_COLOR.withOpacity(.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                    ),
                    splashColor: Constants.LIGHT_BLUE_COLOR,
                    onTap: buttonPressFunction,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Constants.BLUE_COLOR,
                            Constants.BLUE_COLOR.withOpacity(.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: buttonText == null && icon != null
                          ? Icon(
                              icon,
                              size: 35,
                              color: Constants.LIGHT_BLUE_COLOR,
                            )
                          : Text(
                              buttonText ?? "",
                              // "Save",
                              style: TextStyle(
                                color: Constants.LIGHT_BLUE_COLOR,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
  //Custom AppBar
}
