import 'dart:convert';
import 'package:drop_down_list/drop_down_list.dart';

UniversityModel universityModelFromMap(String str) =>
    UniversityModel.fromMap(json.decode(str));

String universityModelToMap(UniversityModel data) => json.encode(data.toMap());

class UniversityModel {
  UniversityModel({
    required this.webPages,
    required this.name,
  });

  List<String> webPages;
  String name;

  factory UniversityModel.fromMap(Map<String, dynamic> json) => UniversityModel(
        webPages: List<String>.from(json["web_pages"].map((x) => x)),
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "web_pages": List<dynamic>.from(webPages.map((x) => x)),
        "name": name,
      };
  static SelectedListItem toSelectableItem(Map<String, dynamic> json) =>
      SelectedListItem(false, json["name"]);
}
