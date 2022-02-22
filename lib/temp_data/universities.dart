import 'dart:convert';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/models/universities/university_model.dart';

class UniversityService {
  static final List<SelectedListItem> _universities = [];

  static Future<List<SelectedListItem>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/university.json');
    final data = await json.decode(response) as List;

    for (int i = 0; i < data.length; i++) {
      var tempUni = UniversityModel.toSelectableItem(data[i]);
      _universities.add(tempUni);
    }
    return _universities;
  }

  static Future<List> getUniversities() async {
    await Future.delayed(const Duration(seconds: 1));
    final String response =
        await rootBundle.loadString('assets/data/university.json');
    final data = await json.decode(response);
    return data;
  }

  static get universities => _universities;
}
