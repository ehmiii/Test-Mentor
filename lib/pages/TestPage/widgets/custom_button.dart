import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String icon;
  final String buttonText;
  final BoxConstraints constrains;
  final VoidCallback press;
  const CustomButton({
    super.key,
    required this.icon,
    required this.buttonText,
    required this.constrains,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constrains.maxWidth * .43,
      height: constrains.maxWidth * .15,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Constants.BLUE_COLOR,
            Constants.LIGHT_BLUE_COLOR,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(2, 2),
            blurRadius: 2,
          )
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        child: InkWell(
          onTap: press,
          splashColor: Constants.DARK_BLUE_COLOR,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          child: LayoutBuilder(builder: (context, cons) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(constrains.maxWidth * .02),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: cons.maxWidth * .5,
                    height: cons.maxWidth * .55,
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 30,
                        color: Constants.DARK_BLACK_COLOR,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: cons.maxWidth * .20,
                    height: cons.maxWidth * .20,
                    child: Image.asset(
                      icon,
                      color: Constants.DARK_BLACK_COLOR,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
