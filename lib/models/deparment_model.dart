import 'dart:convert';

class DepartmentModel {
  final String id;
  final String image;
  final String title;
  final int step;
  final int progress;
  DepartmentModel({
    required this.id,
    required this.image,
    required this.title,
    required this.step,
    required this.progress,
  });

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    return DepartmentModel(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      step: map['step']?.toInt() ?? 0,
      progress: map['progress']?.toInt() ?? 0,
    );
  }

  factory DepartmentModel.fromJson(String source) =>
      DepartmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DepartmentModel(id: $id, image: $image, title: $title, step: $step, progress: $progress)';
  }

  DepartmentModel copyWith({
    String? id,
    String? image,
    String? title,
    int? step,
    int? progress,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      step: step ?? this.step,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'step': step,
      'progress': progress,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepartmentModel &&
        other.id == id &&
        other.image == image &&
        other.title == title &&
        other.step == step &&
        other.progress == progress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        title.hashCode ^
        step.hashCode ^
        progress.hashCode;
  }
}
