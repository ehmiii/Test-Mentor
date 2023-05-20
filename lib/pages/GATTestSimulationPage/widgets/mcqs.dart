import 'package:flutter/material.dart';
import 'package:gat_cs_trainer_app/controllers/home_controller.dart';

import '../../../utils/constants.dart';

// This widget is use to represent GAT Test Page macqs
class McqsWidget extends StatelessWidget {
  final int index;
  final BoxConstraints constraints;
  const McqsWidget({
    super.key,
    required this.index,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q-${index + 1}: An algorithm should have _______ well-defined outputs.",
          style: TextStyle(
            fontSize: 15,
            color: Constants.DARK_BLUE_COLOR,
          ),
        ),
        Text("Answer one"),
        Text("Answer one"),
        Text("Answer one"),
        Text("Answer one"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 4; i++)
              Container(
                padding: EdgeInsets.all(
                  constraints.maxWidth * .02,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * .02,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Constants.DARK_BLUE_COLOR,
                  ),
                ),
                child: Text(
                  i.toString(),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
