import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../utils/constants.dart';
import '../../ResultPage/result_page.dart';

class EditButton extends StatelessWidget {
  final BoxConstraints constrains;
  const EditButton({
    super.key,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const ResultPage(),
            ),
          );
        },
        child: ClipPath(
          clipper: OvalTopBorderClipper(),
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            alignment: Alignment.center,
            width: constrains.maxWidth,
            height: constrains.maxHeight * 0.1,
            decoration: BoxDecoration(
              color: Constants.DARK_BLUE_COLOR,
            ),
            child: Text(
              "Edit",
              style: TextStyle(
                fontSize: 20,
                color: Constants.LIGHT_BLUE_COLOR,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
