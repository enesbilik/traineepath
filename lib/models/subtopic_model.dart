import 'dart:convert';

class SubTopicModel {
  final String title;
  final String subtitle;
  SubTopicModel({
    required this.title,
    required this.subtitle,
  });

  SubTopicModel copyWith({
    String? title,
    String? subtitle,
  }) {
    return SubTopicModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }

  factory SubTopicModel.fromMap(Map<String, dynamic> map) {
    return SubTopicModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTopicModel.fromJson(String source) =>
      SubTopicModel.fromMap(json.decode(source));

  @override
  String toString() => 'SubTopicModel(title: $title, subtitle: $subtitle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubTopicModel &&
        other.title == title &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode;
}
