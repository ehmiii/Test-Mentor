import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';
import '/controllers/test_controller.dart';
import '/utils/Routes/routes.dart';

import '../../../models/user_test_mcqs_model.dart';
import '../../../utils/constants.dart';

class ReviewTestMcqs {
  static Dialog REVIEW_TEST_MCQS(
      BuildContext context, List<UserTestMcqsModel> userMcqsModel) {
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
      child: Container(
        padding: EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Constants.LIGHT_BLUE_COLOR,
        ),
        child: ListView.builder(
          shrinkWrap: true,
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
              margin: EdgeInsets.only(bottom: 5, left: 4, right: 4),
              padding: EdgeInsets.all(
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
                            userMcqsModel[index].userEnteredAnswer &&
                        element == userMcqsModel[index].rightAnswer) {
                      return Container(
                        padding: EdgeInsets.all(2),
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
                            userMcqsModel[index].userEnteredAnswer &&
                        element != userMcqsModel[index].rightAnswer) {
                      return Container(
                        padding: EdgeInsets.all(2),
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
                    } else if (element == userMcqsModel[index].rightAnswer) {
                      return Container(
                        padding: EdgeInsets.all(2),
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
                        decoration: BoxDecoration(),
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
    );
  }
}
