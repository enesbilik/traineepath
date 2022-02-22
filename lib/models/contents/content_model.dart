import 'dart:convert';

class Content {
  Content({
    required this.title,
    required this.subtitle,
    required this.titleContent,
    required this.subtitleContent,
    required this.videos,
  });

  final String title;
  final String subtitle;
  final String titleContent;
  final String subtitleContent;
  final List<String> videos;

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        title: json["title"],
        subtitle: json["subtitle"],
        titleContent: json["title_content"],
        subtitleContent: json["subtitle_content"],
        videos: List<String>.from(json["videos"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "subtitle": subtitle,
        "title_content": titleContent,
        "subtitle_content": subtitleContent,
        "videos": List<dynamic>.from(videos.map((x) => x)),
      };
}
