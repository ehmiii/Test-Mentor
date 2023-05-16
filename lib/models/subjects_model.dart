// To parse this JSON data, do
//
//     final subjectsModel = subjectsModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import '/models/mcqs_model.dart';

SubjectsModel subjectsModelFromJson(String str) =>
    SubjectsModel.fromJson(json.decode(str));

String subjectsModelToJson(SubjectsModel data) => json.encode(data.toJson());

class SubjectsModel extends Equatable {
  SubjectsModel({
    required this.subjectName,
    required this.subSubjects,
  });

  String subjectName;
  List<SubSubject> subSubjects;

  factory SubjectsModel.fromJson(Map<String, dynamic> json) => SubjectsModel(
        subjectName: json["Subject Name"],
        subSubjects: List<SubSubject>.from(
            json["SubSubjects"].map((x) => SubSubject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Subject Name": subjectName,
        "SubSubjects": List<dynamic>.from(subSubjects.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [subjectName, subSubjects];
}

class SubSubject extends Equatable {
  SubSubject({
    required this.subSubjectName,
    required this.mcqs,
  });

  String subSubjectName;
  List<McqsModel> mcqs;

  factory SubSubject.fromJson(Map<String, dynamic> json) => SubSubject(
        subSubjectName: json["SubSubjectName"],
        mcqs: List<McqsModel>.from(json["mcqs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "SubSubjectName": subSubjectName,
        "mcqs": List<McqsModel>.from(mcqs.map((x) => x)),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [subSubjectName, mcqs];
}
