// To parse this JSON data, do
//
//     final userTestMcqsModel = userTestMcqsModelFromJson(jsonString);

import 'dart:convert';

UserTestMcqsModel userTestMcqsModelFromJson(String str) =>
    UserTestMcqsModel.fromJson(json.decode(str));

String userTestMcqsModelToJson(UserTestMcqsModel data) =>
    json.encode(data.toJson());

class UserTestMcqsModel {
  UserTestMcqsModel({
    required this.question,
    required this.wrongAnswer1,
    required this.wrongAnswer2,
    required this.wrongAnswer3,
    required this.rightAnswer,
    required this.userEnteredAnswer,
  });

  String question;
  String wrongAnswer1;
  String wrongAnswer2;
  String wrongAnswer3;
  String rightAnswer;
  String userEnteredAnswer;

  factory UserTestMcqsModel.fromJson(Map<String, dynamic> json) =>
      UserTestMcqsModel(
        question: json["question"],
        wrongAnswer1: json["wrongAnswer1"],
        wrongAnswer2: json["wrongAnswer2"],
        wrongAnswer3: json["wrongAnswer3"],
        rightAnswer: json["rightAnswer"],
        userEnteredAnswer: json["userEnteredAnswer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "wrongAnswer1": wrongAnswer1,
        "wrongAnswer2": wrongAnswer2,
        "wrongAnswer3": wrongAnswer3,
        "rightAnswer": rightAnswer,
        "userEnteredAnswer": userEnteredAnswer,
      };
}
