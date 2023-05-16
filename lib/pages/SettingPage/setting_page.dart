import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/pages/SettingPage/widgets/custom_settings_button.dart';
import '/utils/constants.dart';

import '../../utils/widgets/custom_appbar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.CUSTOM_APPBAR(
        context: context,
        title: "Settings",
      ),
      body: LayoutBuilder(
        builder: (_, constrains) => Container(
          color: Constants.LIGHT_BLUE_COLOR,
          padding: EdgeInsets.only(
            // top: constrains.maxWidth * .02,
            left: constrains.maxWidth * .02,
            right: constrains.maxWidth * .02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: constrains.maxWidth * .20,
                          width: constrains.maxWidth * .20,
                          margin: EdgeInsets.only(
                            top: 8,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Constants.DARK_BLUE_COLOR,
                            ),
                          ),
                          child: ClipOval(
                            child: SvgPicture.asset(
                                Constants.LIGHT_BACKGROUN_LOGO_SVG),
                            // child: Image.asset(
                            //   Constants.LIGHT_BACKGROUN_LOGO,
                            // ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Ahmad Khan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Constants.DARK_BLUE_COLOR,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Account Settings",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.DARK_BLUE_COLOR,
                  ),
                ),
                CustomSettingsButton(
                  constrains: constrains,
                  buttonText: "Edit Profile",
                  pngIcon: Constants.MCQS_FORWARD_ICON,
                ),
                CustomSettingsButton(
                  constrains: constrains,
                  buttonText: "Change Password",
                  pngIcon: Constants.MCQS_FORWARD_ICON,
                ),
                CustomSettingsButton(
                  constrains: constrains,
                  buttonText: "Security & Privacy",
                  pngIcon: Constants.MCQS_FORWARD_ICON,
                ),
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.DARK_BLUE_COLOR,
                  ),
                ),
                CustomSettingsButton(
                  constrains: constrains,
                  buttonText: "Notification",
                ),
                CustomSettingsButton(
                  constrains: constrains,
                  buttonText: "App Updates",
                ),
                Text(
                  "App Settings",
                  style: TextStyle(
                    fontSize: 20,
                    color: Constants.DARK_BLUE_COLOR,
                  ),
                ),
                CustomSettingsButton(
                  constrains: constrains,
                  buttonText: "Dark Mode",
                ),
                CustomSettingsButton(
                  constrains: constrains,
                  buttonText: "Urdu Language",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
