import 'dart:convert';

import 'package:trainee_path/models/contents/subtopic_model.dart';

class MainTopic {
  MainTopic({
    required this.image,
    required this.title,
    required this.subTopics,
  });

  final String image;
  final String title;
  final List<SubTopic> subTopics;

  factory MainTopic.fromJson(String str) => MainTopic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MainTopic.fromMap(Map<String, dynamic> json) => MainTopic(
        image: json["image"],
        title: json["title"],
        subTopics: List<SubTopic>.from(
            json["sub_topics"].map((x) => SubTopic.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "image": image,
        "title": title,
        "sub_topics": List<dynamic>.from(subTopics.map((x) => x.toMap())),
      };
}
