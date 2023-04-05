import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../../controllers/signup_controller.dart';
import '../../../../utils/constants.dart';

class UserInputLock extends StatelessWidget {
  final BoxConstraints constrins;
  const UserInputLock({
    super.key,
    required this.constrins,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Get.find<SignUpController>().getIsQuizPassed
          ? const SizedBox()
          : Container(
              alignment: Alignment.center,
              width: constrins.maxWidth,
              height: constrins.maxHeight * .65,
              color: Constants.DARK_BLUE_COLOR.withOpacity(.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 90,
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Please First give quiz and get minmum 80% marks",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Constants.LIGHT_BLUE_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
