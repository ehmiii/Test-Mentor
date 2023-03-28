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
                  height: constrains.maxHeight * .5,
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
                        "Welcome to TestMentor",
                        style: TextStyle(
                          color: Constants.LIGHT_BLUE_COLOR,
                          fontSize: 27,
                        ),
                      ),
                      SizedBox(
                        height: constrains.maxHeight * .01,
                      ),
                      Text(
                        "From here your success start. TestMentor will make you able to pass NTS test but for now it is only for Computer Science and IT related students.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Constants.LIGHT_BLUE_COLOR,
                          fontSize: 20,
                        ),
                      ),
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
