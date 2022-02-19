import 'package:flutter/material.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/constants.dart';

class SubTopicPage extends StatefulWidget {
  const SubTopicPage({Key? key}) : super(key: key);

  @override
  State<SubTopicPage> createState() => _SubTopicPageState();
}

class _SubTopicPageState extends BaseViewState<SubTopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
    );
  }
}
