import 'package:flutter/material.dart';

import '../../../models/user_test_mcqs_model.dart';
import '../../../utils/constants.dart';

class ReviewTestMcqs {
  static Dialog REVIEW_TEST_MCQS(
      BuildContext context, List<UserTestMcqsModel> userMcqsModel) {
    // final textButtonStyle = TextButton.styleFrom(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(
    //       15,
    //     ),
    //   ),
    // );
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ), //this right here
      child: Container(
        padding: const EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Constants.LIGHT_BLUE_COLOR,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Constants.DARK_BLUE_COLOR,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: Text(
                "User Answered Questions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Constants.DARK_BLUE_COLOR,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            userMcqsModel.length < 1
                ? Center(
                    child: Text(
                      "Apologies, there was no question addressed.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Constants.DARK_BLUE_COLOR,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: userMcqsModel.length,
                      itemBuilder: (_, index) {
                        List<String> userMcqs = [
                          userMcqsModel[index].question,
                          userMcqsModel[index].wrongAnswer1,
                          userMcqsModel[index].wrongAnswer2,
                          userMcqsModel[index].wrongAnswer3,
                          userMcqsModel[index].rightAnswer,
                        ];
                        return Container(
                          margin: const EdgeInsets.only(
                              bottom: 5, left: 4, right: 4),
                          padding: const EdgeInsets.all(
                            4,
                          ),
                          decoration: BoxDecoration(
                            color: Constants.DARK_BLUE_COLOR,
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: userMcqs.map(
                              (element) {
                                print(userMcqsModel[index].userEnteredAnswer);
                                if (element == userMcqsModel[index].question) {
                                  return Container(
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(
                                    //     color: Constants.LIGHT_BLUE_COLOR,
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(4),
                                    // ),
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                } else if (element ==
                                        userMcqsModel[index]
                                            .userEnteredAnswer &&
                                    element ==
                                        userMcqsModel[index].rightAnswer) {
                                  return Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                      ),
                                    ),
                                  );
                                } else if (element ==
                                        userMcqsModel[index]
                                            .userEnteredAnswer &&
                                    element !=
                                        userMcqsModel[index].rightAnswer) {
                                  return Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                      ),
                                    ),
                                  );
                                } else if (element ==
                                    userMcqsModel[index].rightAnswer) {
                                  return Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    decoration: const BoxDecoration(),
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ).toList(),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
