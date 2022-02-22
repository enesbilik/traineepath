import 'dart:convert';

import 'package:trainee_path/models/contents/content_model.dart';

class SubTopic {
  SubTopic({
    required this.title,
    required this.subtitle,
    required this.content,
  });

  final String title;
  final String subtitle;
  final Content content;

  factory SubTopic.fromJson(String str) => SubTopic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubTopic.fromMap(Map<String, dynamic> json) => SubTopic(
        title: json["title"],
        subtitle: json["subtitle"],
        content: Content.fromMap(json["content"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "subtitle": subtitle,
        "content": content.toMap(),
      };
}
