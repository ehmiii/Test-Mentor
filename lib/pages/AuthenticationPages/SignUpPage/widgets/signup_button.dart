import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmentor/controllers/signin_controller.dart';
import 'package:testmentor/controllers/signup_controller.dart';
import 'package:testmentor/utils/Routes/routes.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/widgets/error_dialog.dart';

class SignUpButton extends StatelessWidget {
  SignUpButton({super.key});
  SignUpController signUpController = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 70,
        height: 70,
        child: Stack(
          children: [
            Image.asset(
              Constants.LOGIN_AND_SIGNUP_BUTTON,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Constants.DARK_BLUE_COLOR,
                borderRadius: BorderRadius.circular(50),
                onTap: () async {
                  // ErrorDialog.ERROR_DIALOG(context, "Hello Sir");
                  if (signUpController.getGlobalFormKey.currentState!
                      .validate()) {
                    try {
                      await signUpController
                          .signUpUser()
                          .then(
                            (_) async =>
                                await signUpController.uploadUserData(),
                          )
                          .then(
                            (_) => Get.offAndToNamed(
                              Routes.getSignInPage(),
                            ),
                          );
                    } catch (error) {
                      print(error);
                      ErrorDialog.ERROR_DIALOG(
                          signUpController.getscaffoldKey.currentContext!,
                          signUpController.getErrorMessage);
                    }

                    // catchError((_) {
                    //   ErrorDialog.ERROR_DIALOG(
                    //       context, signUpController.getErrorMessage);
                    // });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
