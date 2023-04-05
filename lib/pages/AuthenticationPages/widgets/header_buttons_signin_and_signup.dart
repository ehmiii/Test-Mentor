import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../utils/Routes/routes.dart';
import '../../../utils/constants.dart';

class HeaderButtonsSignInAndSignUp extends StatelessWidget {
  final bool isSignInPage;
  const HeaderButtonsSignInAndSignUp({
    super.key,
    required this.isSignInPage,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              isSignInPage ? null : Get.offAndToNamed(Routes.getSignInPage());
            },
            child: Text(
              "Sign In",
              style: TextStyle(
                fontSize: isSignInPage ? 30 : 20,
                color: isSignInPage
                    ? Constants.LIGHT_BLUE_COLOR
                    : Constants.LIGHT_BLUE_COLOR.withOpacity(
                        .7,
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              isSignInPage
                  ? Get.offAndToNamed(
                      Routes.getSignUpPage(),
                    )
                  : null;
            },
            splashColor: Constants.DARK_BLUE_COLOR,
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: isSignInPage ? 20 : 30,
                color: isSignInPage
                    ? Constants.LIGHT_BLUE_COLOR.withOpacity(
                        .7,
                      )
                    : Constants.LIGHT_BLUE_COLOR,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}
