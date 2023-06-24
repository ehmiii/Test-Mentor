import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '/controllers/signup_controller.dart';

import '../../../../utils/constants.dart';
import 'give_quiz_button.dart';
import 'input_text.dart';
import 'profile_view_and_upload_button.dart';
import 'selecte_category_button.dart';
import 'signup_button.dart';
import 'user_input_lock.dart';

class SignUpBody extends StatelessWidget {
  final BoxConstraints constrins;
  SignUpBody({
    super.key,
    required this.constrins,
  });
  // final signUpController = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: constrins.maxWidth,
      // height: constrins.maxHeight * .82,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Constants.DARK_BLUE_COLOR,
      ),
      child: GetX<SignUpController>(builder: (signUpController) {
        return signUpController.getIsLoading
            ? SizedBox(
                height: constrins.maxHeight * .8,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                ),
              )
            : Column(
                children: [
                  if (signUpController.getSeletedCategories.isEmpty)
                    const SelectCategoryButton(
                        category: "Please Selecte category"),
                  ...signUpController.getSeletedCategories
                      .map(
                        (e) => SelectCategoryButton(
                          category: e,
                        ),
                      )
                      .toList(),
                  const SizedBox(
                    height: 10,
                  ),
                  const GiveQuizButton(),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 30,
                        ),
                        child: Form(
                          key: signUpController.getGlobalFormKey,
                          child: Column(
                            children: [
                              const ProfileViewAndUploadButton(),
                              const SizedBox(
                                height: 8,
                              ),
                              InputText(
                                hintText: "Enter Name",
                                label: "Name",
                                controller:
                                    signUpController.getUserNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your name";
                                  } else if (value.contains(
                                      RegExp("[0-9-.,+-=!@#\$%&^*()~`\"']"))) {
                                    return "Please enter only alphabets";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InputText(
                                hintText: "Enter Email",
                                label: "Email",
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Constants.DARK_BLUE_COLOR,
                                ),
                                controller: signUpController.getEmailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your email";
                                  } else if (GetUtils.isEmail(value)) {
                                    return null;
                                  } else {
                                    return "Please enter correct email";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InputText(
                                hintText: "Enter Password",
                                label: "Password",
                                prefixIcon: Icon(
                                  Icons.password_rounded,
                                  color: Constants.DARK_BLUE_COLOR,
                                ),
                                // suffixIcon: Icons.visibility,
                                obscureText: signUpController.getIsPasswordHide,
                                controller:
                                    signUpController.getPasswordController,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    signUpController.setIsPasswordHide =
                                        !signUpController.getIsPasswordHide;
                                  },
                                  child: Icon(
                                    signUpController.getIsPasswordHide
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter password";
                                  } else if (value.length < 6) {
                                    return "You password should at least 6 character";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InputText(
                                hintText: "Enter Confirm Password",
                                label: "Confirm Password",
                                // prefixIcon: Icons.password_rounded,
                                obscureText: signUpController.getIsPasswordHide,
                                prefixIcon: Icon(
                                  Icons.password_rounded,
                                  color: Constants.DARK_BLUE_COLOR,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    signUpController.setIsPasswordHide =
                                        !signUpController.getIsPasswordHide;
                                  },
                                  child: Icon(
                                    signUpController.getIsPasswordHide
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),

                                controller: signUpController
                                    .getConfirmPasswordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Re-enter password";
                                  } else if (value !=
                                      signUpController
                                          .getPasswordController.text) {
                                    return "Password doesn't match";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SignUpButton(),
                            ],
                          ),
                        ),
                      ),
                      UserInputLock(constrins: constrins),
                    ],
                  ),
                ],
              );
      }),
    );
  }
}
