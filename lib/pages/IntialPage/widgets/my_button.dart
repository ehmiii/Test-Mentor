import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../utils/constants.dart';

class MyButton extends StatelessWidget {
  final bool isSudentbtn;
  final BoxConstraints constrains;
  const MyButton({
    super.key,
    required this.isSudentbtn,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: Offset(1, 4),
            // blurStyle: BlurStyle.inner,
            // spreadRadius: 4,
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: isSudentbtn
            ? Constants.LIGHT_BLUE_COLOR
            : Constants.DARK_BLUE_COLOR,
        child: InkWell(
            splashColor: isSudentbtn
                ? Constants.DARK_BLUE_COLOR
                : Constants.LIGHT_BLUE_COLOR,
            borderRadius: BorderRadius.circular(50),
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: constrains.maxWidth * .4,
              height: constrains.maxHeight * .07,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                isSudentbtn ? "Student" : "Specialist",
                style: TextStyle(
                  color: isSudentbtn
                      ? Constants.DARK_BLACK_COLOR
                      : Constants.LIGHT_BLUE_COLOR,
                  fontSize: 20,
                ),
              ),
            )),
      ),
    );
  }
}
