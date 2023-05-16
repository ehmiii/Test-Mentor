import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';

class Logo extends StatelessWidget {
  final BoxConstraints constrains;
  const Logo({super.key, required this.constrains});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: constrains.maxWidth * .35,
      // height: constrains.maxWidth * .35,
      child: SvgPicture.asset(
        Constants.LIGHT_BACKGROUN_LOGO_SVG,
        height: constrains.maxWidth * .40,
      ),
      // child: Image.asset(
      //   Constants.LIGHT_BACKGROUN_LOGO,
      //   fit: BoxFit.fill,
    );
  }
}
