import 'package:flutter/material.dart';

class RouteManager {
  static void navigatePageNamed(
    BuildContext context,
    String routeName, [
    Object? arg,
  ]) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arg,
    );
  }

  static void navigatePageNamedRemove(
      {required BuildContext context,
      required String routeName,
      Object? args}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
      arguments: args,
    );
  }
}
