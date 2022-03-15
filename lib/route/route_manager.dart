import 'package:flutter/material.dart';

class RouteManager {
  static void navigatePageNamed(BuildContext context, routeName) {
    Navigator.pushNamed(
      context,
      routeName,
    );
  }

  static void navigatePageNamedRemove(BuildContext context, routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }
}
