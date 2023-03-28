import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:testmentor/utils/constants.dart';

import 'widgets/custom_button.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.CUSTOM_APPBAR(
        context: context,
        leadingButtonText: "Stop",
        leadingButtonPressFunction: () {},
        buttonText: "10:00min",
        buttonPressFunction: () {},
        title: "Quiz",
      ),
      body: LayoutBuilder(
        builder: (_, constrains) => Container(
          color: Constants.LIGHT_BLUE_COLOR,
          padding: EdgeInsets.all(
            constrains.maxWidth * .03,
          ),
          child: Column(
            children: [
              Text(
                "Total Mcqs: 10",
                style: TextStyle(
                  fontSize: 20,
                  color: Constants.DARK_BLACK_COLOR,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.all(
                  constrains.maxWidth * .02,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Constants.DARK_BLUE_COLOR.withOpacity(.7),
                ),
                child: Column(
                  children: [
                    Text(
                      "Who is founder of Pakistan?",
                      style: TextStyle(
                        color: Constants.DARK_BLACK_COLOR,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: constrains.maxHeight * .02,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) => Container(
                        margin: EdgeInsets.symmetric(
                          vertical: constrains.maxHeight * .013,
                        ),
                        height: constrains.maxHeight * .11,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Constants.BLUE_COLOR,
                              Constants.LIGHT_BLUE_COLOR,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Constants.DARK_BLACK_COLOR.withOpacity(.5),
                              offset: const Offset(
                                3,
                                3,
                              ),
                              blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Text(
                          "Muhammad Ali Jannah $index",
                          style: TextStyle(
                            fontSize: 20,
                            color: Constants.DARK_BLACK_COLOR,
                          ),
                        ),
                      ),
                      itemCount: 4,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current Mcqs: 2",
                    style: TextStyle(
                      fontSize: 20,
                      color: Constants.DARK_BLACK_COLOR,
                    ),
                  ),
                  Text(
                    "Left Mcqs: 8",
                    style: TextStyle(
                      fontSize: 20,
                      color: Constants.DARK_BLACK_COLOR,
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              CustomButton(
                icon: Constants.SKIP_ICON,
                buttonText: "Skip",
                constrains: constrains,
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Container(
                alignment: Alignment.center,
                margin:
                    EdgeInsets.symmetric(horizontal: constrains.maxWidth * .02),
                height: constrains.maxHeight * .1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Constants.BLUE_COLOR,
                      Constants.LIGHT_BLUE_COLOR,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Constants.DARK_BLACK_COLOR.withOpacity(.5),
                      offset: const Offset(
                        3,
                        3,
                      ),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  "Left Time: 9Min 31Sec",
                  style: TextStyle(
                    color: Constants.DARK_BLACK_COLOR,
                    fontSize: 20,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
