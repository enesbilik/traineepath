import 'dart:convert';

class Content {
  final String image;
  final String mainTitle;
  final String title;
  final String titleContent;
  final String subtitle;
  final String subtitleContent;
  final String video;
  Content({
    required this.mainTitle,
    required this.title,
    required this.subtitle,
    required this.titleContent,
    required this.subtitleContent,
    required this.video,
    required this.image,
  });

  Content copyWith({
    String? mainTitle,
    String? title,
    String? subtitle,
    String? titleContent,
    String? subtitleContent,
    String? video,
    String? image,
  }) {
    return Content(
      mainTitle: mainTitle ?? this.mainTitle,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      titleContent: titleContent ?? this.titleContent,
      subtitleContent: subtitleContent ?? this.subtitleContent,
      video: video ?? this.video,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mainTitle': mainTitle,
      'title': title,
      'subtitle': subtitle,
      'titleContent': titleContent,
      'subtitleContent': subtitleContent,
      'video': video,
      'image': image,
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      mainTitle: map['mainTitle'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      titleContent: map['titleContent'] ?? '',
      subtitleContent: map['subtitleContent'] ?? '',
      video: map['video'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Content(mainTitle: $mainTitle, title: $title, subtitle: $subtitle, titleContent: $titleContent, subtitleContent: $subtitleContent, video: $video, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Content &&
        other.mainTitle == mainTitle &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.titleContent == titleContent &&
        other.subtitleContent == subtitleContent &&
        other.video == video &&
        other.image == image;
  }

  @override
  int get hashCode {
    return mainTitle.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        titleContent.hashCode ^
        subtitleContent.hashCode ^
        video.hashCode ^
        image.hashCode;
  }
}
