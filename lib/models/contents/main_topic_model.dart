// To parse this JSON data, do
//
//     final mainTopic = mainTopicFromMap(jsonString);

import 'dart:convert';

import 'package:trainee_path/models/contents/subtopic_model.dart';

class MainTopic {
  MainTopic({
    required this.id,
    required this.image,
    required this.title,
    required this.subTopics,
  });

  final int id;
  final String image;
  final String title;
  final List<SubTopic> subTopics;

  factory MainTopic.fromJson(String str) => MainTopic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MainTopic.fromMap(Map<String, dynamic> json) => MainTopic(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        subTopics: List<SubTopic>.from(
            json["sub_topics"].map((x) => SubTopic.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "title": title,
        "sub_topics": List<dynamic>.from(subTopics.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'MainTopic(id: $id, image: $image, title: $title, subTopics: $subTopics)';
  }
}
