import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';
import '/controllers/test_controller.dart';
import '/utils/Routes/routes.dart';

import '../../../utils/constants.dart';

class TestMcqsSelectionDialog {
  static Dialog TEST_MCQS_SELECTION_DIALOG(BuildContext context,
      {bool isRetest = false}) {
    final List<int> testMcqsLength = [
      10,
      15,
      20,
    ];
    final textButtonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
    );
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ), //this right here
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Constants.BLUE_COLOR,
                  Constants.LIGHT_BLUE_COLOR,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              border: Border.all(
                color: Constants.DARK_BLUE_COLOR,
              ),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: testMcqsLength
                  .map(
                    (length) => Container(
                      width: double.infinity,
                      height: 70,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Constants.BLUE_COLOR,
                            Constants.LIGHT_BLUE_COLOR,
                          ],
                          // begin: Alignment.bottomRight,
                          // end: Alignment.topLeft,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Constants.DARK_BLUE_COLOR.withOpacity(.5),
                            offset: const Offset(2, 4),
                            blurRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          Get.find<HomeController>().setSelectedLengthofQuiz =
                              length;
                          Get.back();
                          Get.delete<TestController>();
                          isRetest
                              ? Get.offAndToNamed(Routes.getTestPage())
                              : Get.toNamed(Routes.getTestPage());
                        },
                        style: textButtonStyle,
                        child: Text(
                          "$length MCQs Test",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     Container(
            //       width: double.infinity,
            //       height: 70,
            //       margin: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: [
            //             Constants.BLUE_COLOR,
            //             Constants.LIGHT_BLUE_COLOR,
            //           ],
            //           // begin: Alignment.bottomRight,
            //           // end: Alignment.topLeft,
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Constants.DARK_BLUE_COLOR.withOpacity(.5),
            //             offset: const Offset(2, 4),
            //             blurRadius: 2,
            //           ),
            //         ],
            //         borderRadius: BorderRadius.circular(
            //           15,
            //         ),
            //       ),
            //       child: TextButton(
            //         onPressed: () async {
            //           Get.find<HomeController>().setSelectedLengthofQuiz = 15;
            //           Get.back();
            //           Get.delete<TestController>();
            //           isRetest
            //               ? Get.offAndToNamed(Routes.getTestPage())
            //               : Get.toNamed(Routes.getTestPage());
            //         },
            //         style: textButtonStyle,
            //         child: const Text(
            //           "15 MCQs Test",
            //           style: TextStyle(
            //             fontSize: 20,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       width: double.infinity,
            //       height: 70,
            //       margin: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: [
            //             Constants.BLUE_COLOR,
            //             Constants.LIGHT_BLUE_COLOR,
            //           ],
            //           // begin: Alignment.bottomRight,
            //           // end: Alignment.topLeft,
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Constants.DARK_BLUE_COLOR.withOpacity(.5),
            //             offset: const Offset(2, 4),
            //             blurRadius: 2,
            //           ),
            //         ],
            //         borderRadius: BorderRadius.circular(
            //           15,
            //         ),
            //       ),
            //       child: TextButton(
            //         onPressed: () {},
            //         style: textButtonStyle,
            //         child: const Text(
            //           "20 MCQs Test",
            //           style: TextStyle(
            //             fontSize: 20,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       width: double.infinity,
            //       height: 70,
            //       margin: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: [
            //             Constants.BLUE_COLOR,
            //             Constants.LIGHT_BLUE_COLOR,
            //           ],
            //           // begin: Alignment.bottomRight,
            //           // end: Alignment.topLeft,
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Constants.DARK_BLUE_COLOR.withOpacity(.5),
            //             offset: const Offset(2, 4),
            //             blurRadius: 2,
            //           ),
            //         ],
            //         borderRadius: BorderRadius.circular(
            //           15,
            //         ),
            //       ),
            //       child: TextButton(
            //         onPressed: () {},
            //         style: textButtonStyle,
            //         child: const Text(
            //           "30 MCQs Test",
            //           style: TextStyle(
            //             fontSize: 20,
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //   ],
            // ),
          ),
          Positioned(
            top: -8,
            right: -8,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).maybePop();
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: ClipOval(
                  child: Image.asset(
                    Constants.CLOSE_ICON,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
