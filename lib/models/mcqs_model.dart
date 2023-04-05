// To parse this JSON data, do
//
//     final mcqsModel = mcqsModelFromJson(jsonString);

import 'dart:convert';

McqsModel mcqsModelFromJson(String str) => McqsModel.fromJson(json.decode(str));

String mcqsModelToJson(McqsModel data) => json.encode(data.toJson());

class McqsModel {
  McqsModel({
    required this.uploaderName,
    required this.category,
    required this.question,
    required this.wrongAnswer1,
    required this.wrongAnswer2,
    required this.wrongAnswer3,
    required this.rightAnswer,
    required this.userId,
    this.id,
  });

  String uploaderName;
  String category;
  String question;
  String wrongAnswer1;
  String wrongAnswer2;
  String wrongAnswer3;
  String rightAnswer;
  String? id;
  String? userId;

  factory McqsModel.fromJson(Map<String, dynamic> json) => McqsModel(
        uploaderName: json["uploaderName"],
        category: json["category"],
        question: json["question"],
        wrongAnswer1: json["wrongAnswer1"],
        wrongAnswer2: json["wrongAnswer2"],
        wrongAnswer3: json["wrongAnswer3"],
        rightAnswer: json["rightAnswer"],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        "uploaderName": uploaderName,
        "category": category,
        "question": question,
        "wrongAnswer1": wrongAnswer1,
        "wrongAnswer2": wrongAnswer2,
        "wrongAnswer3": wrongAnswer3,
        "rightAnswer": rightAnswer,
        "userId": userId,
      };
}
