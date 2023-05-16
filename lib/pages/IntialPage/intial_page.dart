import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'widgets/logo.dart';
import 'widgets/my_button.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constrains) => Stack(
          children: [
            Container(
              color: Constants.LIGHT_BLUE_COLOR,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Logo(
                  constrains: constrains,
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Container(
                  height: constrains.maxHeight * .55,
                  width: constrains.maxWidth,
                  padding: EdgeInsets.symmetric(
                    horizontal: constrains.maxWidth * .05,
                  ),
                  decoration: BoxDecoration(
                    color: Constants.DARK_GRAY_COLOR,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: constrains.maxHeight * .03,
                      ),
                      Text(
                        "Welcome to GAT(CS) Trainer APP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Constants.LIGHT_BLUE_COLOR,
                          fontSize: 27,
                        ),
                      ),
                      SizedBox(
                        height: constrains.maxHeight * .01,
                      ),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Constants.LIGHT_BLUE_COLOR,
                          fontSize: 20,
                        ),
                        const TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Dear User, Thank you for choosing our app for test preparation. Please select the mode that suits you:",
                            ),
                            TextSpan(
                              text: "\nSpecialist:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " If you have IT skills and want to contribute, click on Specialist.",
                            ),
                            TextSpan(
                              text: "\nStudent: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "If you want to prepare for test, click on Student.",
                            ),
                            TextSpan(
                              text:
                                  "\nWe value your choice and aim to provide the best experience for all users.",
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Text(
                      //     """Dear User, Thank you for choosing our app for test preparation. Please select the mode that suits you: Specialist: If you have IT skills and want to contribute, click here.\nStudent: If you want to prepare for tests, click here. We value your input and aim to provide the best experience for all users.\nBest regards,\nAK Production Team""",
                      //     textAlign: TextAlign.justify,
                      //     style: TextStyle(
                      //       color: Constants.LIGHT_BLUE_COLOR,
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      // ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyButton(
                            constrains: constrains,
                            isSudentbtn: true,
                          ),
                          MyButton(
                            constrains: constrains,
                            isSudentbtn: false,
                          ),
                        ],
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
