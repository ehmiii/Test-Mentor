import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:testmentor/controllers/signin_controller.dart';

import '../../../../utils/constants.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscure;
  final String? Function(String?)? validator;
  const InputText({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscure = false,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscure,
      // strutStyle: StrutStyle(height: 2),
      decoration: InputDecoration(
        suffix: isPassword
            ? GestureDetector(
                onTap: () {
                  Get.find<SignInController>().setIsPasswordHide =
                      !Get.find<SignInController>().getIsPasswordHide;
                },
                child: Obx(() {
                  return Get.find<SignInController>().getIsPasswordHide
                      ? Icon(
                          Icons.visibility,
                          color: Constants.DARK_BLUE_COLOR,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: Constants.DARK_BLUE_COLOR,
                          //
                        );
                }),
              )
            : null,
        label: Padding(
          padding: const EdgeInsets.only(
              // bottom: 15,
              ),
          child: Text(
            label,
            style: TextStyle(
              color: Constants.BLUE_COLOR,
            ),
          ),
        ),
        labelStyle: TextStyle(
          color: Constants.DARK_GRAY_COLOR,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isPassword ? 20 : 25,
          horizontal: 15,
        ),
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        fillColor: Constants.LIGHT_BLUE_COLOR,
        hintStyle: TextStyle(
          color: Constants.DARK_BLUE_COLOR.withOpacity(.6),
        ),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
