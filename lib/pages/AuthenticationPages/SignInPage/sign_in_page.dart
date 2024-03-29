import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/controllers/signin_controller.dart';
import '/utils/constants.dart';
import '/utils/widgets/error_dialog.dart';
import '../../../utils/Routes/routes.dart';
import '../../../utils/widgets/show_toast.dart';
import 'widgets/input_text.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInController signInController = Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Constants.BLUE_COLOR,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            Image.asset(
              Constants.AUTHENTICATION_BACK_BUTTON,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.offAllNamed(Routes.getInitialPage());
                },
                splashColor: Constants.DARK_BLUE_COLOR,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.getInitialPage());
        return false;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          key: signInController.getScaffoldKey,
          backgroundColor: Constants.LIGHT_BLUE_COLOR,
          appBar: appBar,
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              color: Constants.BLUE_COLOR,
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: signInController.getFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // const HeaderButtonsSignInAndSignUp(
                      //   isSignInPage: true,
                      // ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      Flexible(flex: 2, child: Container()),
                      SizedBox(
                        height: constraints.maxWidth * .7,
                        width: constraints.maxWidth * .7,
                        // child: GifView.asset(
                        //   Constants.DAR,
                        //   frameRate: 120,
                        // )
                        child: SvgPicture.asset(
                          Constants.DARK_BACKGROUN_LOGO_SVG,
                        ),
                      ),
                      Flexible(flex: 3, child: Container()),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Constants.DARK_BLUE_COLOR),
                        child: Obx(
                          () => signInController.getIsLoading
                              ? SizedBox(
                                  height: constraints.maxHeight * .45,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Constants.LIGHT_BLUE_COLOR,
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 24, right: 24),
                                      child: InputText(
                                        controller:
                                            signInController.getEmailController,
                                        label: "Email",
                                        hintText: "example.gmail.com",
                                        prefixIcon: Icons.email_rounded,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter email";
                                          } else if (!GetUtils.isEmail(value)) {
                                            return "Please enter a valid email";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        left: 24,
                                        right: 24,
                                      ),
                                      child: InputText(
                                        obscure:
                                            signInController.getIsPasswordHide,
                                        controller: signInController
                                            .getPasswordController,
                                        label: "Password",
                                        hintText: "Enter Password",
                                        prefixIcon: Icons.password_rounded,
                                        isPassword: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter password";
                                          } else if (value.length < 6) {
                                            return "Please enter password at least 6 character";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              // padding:,
                                              ),
                                          onPressed: () {
                                            signInController
                                                .getEmailController.text = "";
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.info,
                                              headerAnimationLoop: false,
                                              body: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: signInController
                                                      .getEmailController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please enter your email";
                                                    } else if (!value.isEmail) {
                                                      return "Please enter correct email";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    label: Text("Email"),
                                                    hintText:
                                                        "Please enter your email",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              autoDismiss: false,
                                              onDismissCallback: (vlaue) {},
                                              btnOkOnPress: () async {
                                                if (signInController
                                                    .getEmailController
                                                    .text
                                                    .isEmpty) {
                                                  ShowToast.SHOW_TOAST(
                                                      "Please enter your email");
                                                } else if (!GetUtils.isEmail(
                                                    signInController
                                                        .getEmailController
                                                        .text)) {
                                                  ShowToast.SHOW_TOAST(
                                                      "Please enter correct email");
                                                } else {
                                                  try {
                                                    await signInController
                                                        .forgetPassword();
                                                    Get.back();
                                                  } on Exception catch (e) {
                                                    ShowToast.SHOW_TOAST(
                                                      e.toString(),
                                                    );
                                                  }
                                                }
                                              },
                                              btnCancelOnPress: () {
                                                Get.back();
                                              },
                                            ).show();
                                          },
                                          child: Text(
                                            "Forget Password?",
                                            style: TextStyle(
                                                color:
                                                    Constants.LIGHT_BLUE_COLOR,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // this container is used for login button
                                    // SizedBox(
                                    //   height: constraints.maxHeight * .04,
                                    // ),
                                    SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            Constants.LOGIN_AND_SIGNUP_BUTTON,
                                          ),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              splashColor:
                                                  Constants.DARK_BLUE_COLOR,
                                              onTap: () async {
                                                if (signInController
                                                    .getFormKey.currentState!
                                                    .validate()) {
                                                  try {
                                                    await signInController
                                                        .singInUser()
                                                        .then((_) async {
                                                      await signInController
                                                          .getUserData()
                                                          .then(
                                                            (_) => signInController
                                                                    .getUserInfo
                                                                    .isAdmin!
                                                                ? Get.offAllNamed(
                                                                    Routes
                                                                        .getUsersDetailsPage())
                                                                : Get
                                                                    .offAllNamed(
                                                                    Routes
                                                                        .getHomePage(),
                                                                  ),
                                                          );
                                                    });
                                                  } catch (error) {
                                                    ErrorDialog.ERROR_DIALOG(
                                                        signInController
                                                            .getScaffoldKey
                                                            .currentContext!,
                                                        signInController
                                                            .geterrorMessage);
                                                  }
                                                }
                                              },
                                              // child:
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * .04,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account?",
                                          style: TextStyle(
                                            color: Constants.LIGHT_BLUE_COLOR,
                                          ),
                                        ),
                                        TextButton(
                                          child: Text(
                                            "SignUp",
                                            style: TextStyle(
                                              color: Constants.LIGHT_BLUE_COLOR,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.offAndToNamed(
                                              Routes.getSignUpPage(),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
