import 'dart:convert';

class TopicModel {
  final String title;
  final String id;
  TopicModel({
    required this.title,
    required this.id,
  });

  TopicModel copyWith({
    String? title,
    String? id,
  }) {
    return TopicModel(
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
    };
  }

  factory TopicModel.fromMap(Map<String, dynamic> map) {
    return TopicModel(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicModel.fromJson(String source) =>
      TopicModel.fromMap(json.decode(source));

  @override
  String toString() => 'TopicModel(title: $title, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TopicModel && other.title == title && other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ id.hashCode;
}
