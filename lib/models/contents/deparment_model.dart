//     final departmentModel = departmentModelFromMap(jsonString);

import 'dart:convert';

class DepartmentModel {
  DepartmentModel({
    required this.id,
    required this.image,
    required this.title,
    required this.topics,
  });

  final int id;
  final String image;
  final String title;
  final List<int> topics;

  factory DepartmentModel.fromJson(String str) =>
      DepartmentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepartmentModel.fromMap(Map<String, dynamic> json) => DepartmentModel(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        topics: List<int>.from(json["topics"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "title": title,
        "topics": List<dynamic>.from(topics.map((x) => x)),
      };
}
