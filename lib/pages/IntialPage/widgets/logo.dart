import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class Logo extends StatelessWidget {
  final BoxConstraints constrains;
  const Logo({super.key, required this.constrains});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constrains.maxWidth * .35,
      height: constrains.maxWidth * .35,
      child: Image.asset(
        Constants.LIGHT_BACKGROUN_LOGO,
        fit: BoxFit.fill,
      ),
    );
  }
}
