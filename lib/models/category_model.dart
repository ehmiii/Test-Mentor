// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel extends Equatable {
  CategoryModel({
    required this.categoryName,
    required this.subCategories,
    required this.categoryImage,
  });

  String categoryName;
  List<SubCategory> subCategories;
  String categoryImage;

  @override
  List<Object> get props => [categoryName, subCategories, categoryImage];

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryName: json["categoryName"],
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
        categoryImage: json["categoryImage"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "subCategories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
        "categoryImage": categoryImage,
      };
}

class SubCategory {
  SubCategory({
    required this.name,
    required this.image,
  });

  String name;
  String image;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}
