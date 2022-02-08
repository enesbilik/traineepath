import 'package:flutter/material.dart';

abstract class BaseAuthView<T extends StatefulWidget> extends State<T> {
  double dynamicHeight(double value) =>
      MediaQuery.of(context).size.height * value;

  double dynamicWidth(double value) =>
      MediaQuery.of(context).size.width * value;

  EdgeInsets get basePadding => const EdgeInsets.all(16);

  SizedBox get baseSpace => const SizedBox(height: 20);
  SizedBox get baseSpace2 => const SizedBox(height: 32);
}
