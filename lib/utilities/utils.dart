import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainee_path/constants/api_key.dart';
import 'package:trainee_path/constants/auth_data.dart';
import 'package:trainee_path/constants/http_constants.dart';

class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(AuthData.doneText),
            onPressed: onClicked,
          ),
        ),
      );

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 16)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static String createUrl(String name) {
    return "$baseUrl$name.json?auth=$API_KEY";
  }
}
