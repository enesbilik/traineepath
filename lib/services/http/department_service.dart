import 'dart:convert';

import 'package:trainee_path/models/contents/deparment_model.dart';
import 'package:http/http.dart' as http;
import 'package:trainee_path/utilities/utils.dart';

class DepartmentService {
  static final DepartmentService _singleton = DepartmentService._internal();

  factory DepartmentService() {
    return _singleton;
  }
  DepartmentService._internal();

  static String url = Utils.createUrl("departments");

  static Future<List<DepartmentModel>> fetchDepartments() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<DepartmentModel>((json) => DepartmentModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
