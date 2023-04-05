// To parse this JSON data, do
//
//     final userAuthenticationModel = userAuthenticationModelFromJson(jsonString);

import 'dart:convert';

UserAuthenticationModel userAuthenticationModelFromJson(String str) =>
    UserAuthenticationModel.fromJson(json.decode(str));

String userAuthenticationModelToJson(UserAuthenticationModel data) =>
    json.encode(data.toJson());

class UserAuthenticationModel {
  UserAuthenticationModel({
    required this.idToken,
    required this.tokenExpiresIn,
    required this.refreshToken,
  });

  String idToken;
  String tokenExpiresIn;
  String refreshToken;

  factory UserAuthenticationModel.fromJson(Map<String, dynamic> json) =>
      UserAuthenticationModel(
        idToken: json["idToken"],
        tokenExpiresIn: json["tokenExpiresIn"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
        "tokenExpiresIn": tokenExpiresIn,
        "refreshToken": refreshToken,
      };
}
