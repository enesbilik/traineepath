import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trainee_path/models/contents/main_topic_model.dart';
import 'package:trainee_path/utilities/utils.dart';

class MainTopicService {
  static final MainTopicService _singleton = MainTopicService._internal();

  factory MainTopicService() {
    return _singleton;
  }
  MainTopicService._internal();

  static String url = Utils.createUrl("main_topics");

  static Future<List<MainTopic>> fetchTopics() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<MainTopic>((json) => MainTopic.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
