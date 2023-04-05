import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class InputText extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  const InputText(
      {super.key,
      required this.hintText,
      required this.label,
      required this.controller,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      cursorColor: Constants.DARK_BLUE_COLOR,
      style: TextStyle(
        color: Constants.DARK_BLUE_COLOR,
        fontSize: 20,
      ),
      // onSaved: (newValue) {},
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Constants.LIGHT_BLUE_COLOR,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            50,
          ),
        ),
        contentPadding: const EdgeInsets.all(
          20,
        ),
        hintText: hintText,
        // labelText: label,
        hintStyle: TextStyle(
          color: Constants.DARK_BLUE_COLOR.withOpacity(
            .6,
          ),
          fontSize: 20,
        ),
      ),
    );
  }
}
