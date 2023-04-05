// ignore_for_file: non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class ErrorDialog {
  static ERROR_DIALOG(BuildContext context, String message) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      context: context,
      dialogBackgroundColor: Constants.LIGHT_BLUE_COLOR,
      dialogType: DialogType.error,
      body: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Constants.DARK_BLUE_COLOR,
        ),
      ),
      btnCancelOnPress: () {
        Get.back();
      },
    ).show();
  }
}
