// To parse this JSON data, do
//
//     final userInformationModel = userInformationModelFromJson(jsonString);

import 'dart:convert';

UserInformationModel userInformationModelFromJson(String str) =>
    UserInformationModel.fromJson(json.decode(str));

String userInformationModelToJson(UserInformationModel data) =>
    json.encode(data.toJson());

class UserInformationModel {
  UserInformationModel({
    required this.userName,
    required this.email,
    required this.userId,
    required this.profileImageUrl,
    required this.specialization,
    required this.isQuizPassed,
    this.id,
    this.isAdmin,
  });

  String userName;
  String email;
  String userId;
  String profileImageUrl;
  String specialization;
  bool isQuizPassed;
  bool? isAdmin;

  String? id;

  factory UserInformationModel.fromJson(Map<String, dynamic> json) =>
      UserInformationModel(
        userName: json["userName"],
        email: json["email"],
        userId: json["userId"],
        profileImageUrl: json["profileImageUrl"],
        isQuizPassed: json["isQuizPassed"],
        specialization: json["specialization"],
        isAdmin: json["isAdmin"] ?? false,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "userId": userId,
        "profileImageUrl": profileImageUrl,
        "isQuizPassed": isQuizPassed,
        "specialization": specialization,
        "isAdmin": isAdmin,
        "id": id,
      };
}
