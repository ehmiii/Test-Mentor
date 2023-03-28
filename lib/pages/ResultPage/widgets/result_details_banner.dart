import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ResultDetailsBanner extends StatelessWidget {
  final BoxConstraints constrains;
  const ResultDetailsBanner({
    super.key,
    required this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(
      //     horizontal: constrains.maxWidth * .1),
      padding: EdgeInsets.all(
        constrains.maxWidth * .02,
      ),
      decoration: BoxDecoration(
        color: Constants.BLUE_COLOR,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "Score",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
              Text(
                "80/100",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Right",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
              Text(
                "8",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Wrong",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
              Text(
                "1",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Skipped",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
              Text(
                "1",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
