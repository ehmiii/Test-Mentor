import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'widgets/edit_button.dart';
import 'widgets/mcqs_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.CUSTOM_APPBAR(
          context: context, title: "Profile", buttonText: "Edit"),
      body: LayoutBuilder(builder: (context, constrains) {
        return Container(
          width: constrains.maxWidth,
          color: Constants.LIGHT_BLUE_COLOR,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(constrains.maxWidth * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: constrains.maxWidth * .15,
                            ),
                            Positioned(
                              bottom: -2,
                              right: -2,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Constants.DARK_BLACK_COLOR,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Full Name",
                      style: TextStyle(
                        color: Constants.DARK_BLACK_COLOR,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: constrains.maxWidth * .02,
                      ),
                      height: constrains.maxHeight * .09,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Constants.DARK_GRAY_COLOR,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: TextFormField(
                        // style: TextStyle(),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.all(constrains.maxWidth * .03),
                          hintText: "Ahmad Khan",
                          hintStyle: TextStyle(
                            color: Constants.LIGHT_BLUE_COLOR,
                            fontSize: 20,
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: Constants.LIGHT_BLUE_COLOR,
                      ),
                    ),
                    SizedBox(
                      height: constrains.maxWidth * 0.03,
                    ),
                    Text(
                      "Specialization",
                      style: TextStyle(
                        color: Constants.DARK_BLACK_COLOR,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: constrains.maxWidth * .02,
                      ),
                      height: constrains.maxHeight * .09,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Constants.DARK_GRAY_COLOR,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: TextFormField(
                        // style: TextStyle(),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.all(constrains.maxWidth * .03),
                          hintText: "Flutter & Dart Developer",
                          hintStyle: TextStyle(
                            color: Constants.LIGHT_BLUE_COLOR,
                            fontSize: 20,
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: Constants.LIGHT_BLUE_COLOR,
                      ),
                    ),
                    SizedBox(
                      height: constrains.maxWidth * 0.03,
                    ),
                    McqsSection(
                      constrains: constrains,
                    ),
                  ],
                ),
              ),
              EditButton(
                constrains: constrains,
              )
            ],
          ),
        );
      }),
    );
  }
}
