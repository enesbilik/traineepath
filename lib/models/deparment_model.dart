import 'dart:convert';

class DepartmentModel {
  final String image;
  final String title;
  final int step;
  final int progress;
  DepartmentModel({
    required this.image,
    required this.title,
    required this.step,
    required this.progress,
  });

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    return DepartmentModel(
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
    return 'DepartmentModel(image: $image, title: $title, step: $step, progress: $progress)';
  }
}
