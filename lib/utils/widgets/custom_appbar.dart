// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBar {
  // Custom AppBar
  static PreferredSizeWidget CUSTOM_APPBAR({
    required BuildContext context,
    String? title,
    String? buttonText,
    Widget? widget,
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
        buttonText == null && widget == null
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
                      child: buttonText == null && widget != null
                          ? widget
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
}
