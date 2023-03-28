import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class McqsSection extends StatelessWidget {
  final BoxConstraints constrains;
  const McqsSection({super.key, required this.constrains});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Your Posted MCQs",
          style: TextStyle(
            color: Constants.DARK_BLACK_COLOR,
            fontSize: 15,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: constrains.maxWidth * .02,
          ),
          padding: EdgeInsets.symmetric(vertical: constrains.maxWidth * .01),
          height: constrains.maxHeight * .40,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Constants.DARK_GRAY_COLOR,
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: constrains.maxWidth * 0.03,
                vertical: constrains.maxWidth * .02,
              ),
              padding: EdgeInsets.all(constrains.maxWidth * 0.01),
              height: constrains.maxHeight * .2,
              decoration: BoxDecoration(
                color: Constants.LIGHT_BLUE_COLOR,
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DART",
                    style: TextStyle(
                      color: Constants.DARK_BLACK_COLOR,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: constrains.maxWidth,
                    height: 100,
                    child: GridView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 6.0,
                        mainAxisExtent: constrains.maxWidth * 0.3,
                      ),
                      itemBuilder: (_, index) => Container(
                        width: constrains.maxWidth * 0.3,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Constants.DARK_GRAY_COLOR,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: FittedBox(
                                child: Text(
                                  "MCQs $index",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Constants.LIGHT_BLUE_COLOR),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                Constants.MCQS_FORWARD_ICON,
                              ),
                            )
                          ],
                        ),
                      ),
                      itemCount: 50,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
