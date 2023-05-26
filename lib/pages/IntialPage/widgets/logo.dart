import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';

class Logo extends StatelessWidget {
  final BoxConstraints constrains;
  Logo({super.key, required this.constrains});

  @override
  Widget build(BuildContext context) {
    // controller.loop = false;
    return SizedBox(
      width: constrains.maxWidth * .7,
      height: constrains.maxWidth * .70,
      child: SvgPicture.asset(
        Constants.LIGHT_BACKGROUN_LOGO_SVG,
      ),
      // child: Image.asset(
      //   // Constants.LIGHT_BACKGROUN_LOGO_SVG,
      //   Constants.LIGHT_BACKGROUN_LOGO_GIF,
      //   // height: constrains.maxWidth * .40,
      // ),
      // child: Image.asset(
      //   Constants.LIGHT_BACKGROUN_LOGO,
      //   fit: BoxFit.fill,
    );
  }
}
