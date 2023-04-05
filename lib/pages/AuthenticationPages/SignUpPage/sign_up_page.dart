import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testmentor/controllers/signup_controller.dart';
import 'package:testmentor/utils/constants.dart';

import '../../../utils/Routes/routes.dart';
import '../../../utils/widgets/category_selection_dialog.dart';
import '../widgets/header_buttons_signin_and_signup.dart';
import 'widgets/give_quiz_button.dart';
import 'widgets/input_text.dart';
import 'widgets/profile_view_and_upload_button.dart';
import 'widgets/selecte_category_button.dart';
import 'widgets/signup_body.dart';
import 'widgets/signup_button.dart';
import 'widgets/user_input_lock.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constrins) {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        key: Get.find<SignUpController>().getscaffoldKey,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constrins.maxWidth,
              minHeight: constrins.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Container(
                color: Constants.BLUE_COLOR,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const HeaderButtonsSignInAndSignUp(
                      isSignInPage: false,
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    SignUpBody(
                      constrins: constrins,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
