// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromMap(jsonString);

import 'dart:convert';

import 'package:trainee_path/models/contents/main_topic_model.dart';

class DepartmentModel {
  DepartmentModel({
    required this.id,
    required this.image,
    required this.title,
    required this.mainTopics,
  });

  final int id;
  final String image;
  final String title;
  final List<MainTopic> mainTopics;

  factory DepartmentModel.fromJson(String str) =>
      DepartmentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepartmentModel.fromMap(Map<String, dynamic> json) => DepartmentModel(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        mainTopics: List<MainTopic>.from(
            json["main_topics"].map((x) => MainTopic.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "title": title,
        "main_topics": List<dynamic>.from(mainTopics.map((x) => x.toMap())),
      };
}
