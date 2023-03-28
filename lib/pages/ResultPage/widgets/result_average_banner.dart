import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ResultAverageBanner extends StatelessWidget {
  final BoxConstraints constrains;
  const ResultAverageBanner({
    super.key,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: constrains.maxWidth * .7,
          height: constrains.maxWidth * .15,
          padding: EdgeInsets.symmetric(
              horizontal: constrains.maxWidth * .03,
              vertical: constrains.maxWidth * .02),
          decoration: BoxDecoration(
            color: Constants.BLUE_COLOR,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          ),
          child: LayoutBuilder(builder: (context, cons) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      width: cons.maxWidth * .7,
                      height: cons.maxWidth * .08,
                      decoration: BoxDecoration(
                        color: Constants.LIGHT_BLUE_COLOR,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Container(
                      width: cons.maxWidth * .5,
                      height: cons.maxWidth * .08,
                      decoration: BoxDecoration(
                        color: Constants.DARK_BLUE_COLOR,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    '9 out of 10',
                    style: TextStyle(
                      fontSize: 18,
                      color: Constants.LIGHT_BLUE_COLOR,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        Container(
          width: constrains.maxWidth * .23,
          height: constrains.maxWidth * .15,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Constants.DARK_BLUE_COLOR,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "90",
                style: TextStyle(
                  fontSize: 18,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
              Text(
                "Average",
                style: TextStyle(
                  fontSize: 18,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
