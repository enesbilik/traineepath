import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/constants/constants.dart';

class AppTheme {
  static final AppTheme _singleton = AppTheme._internal();

  factory AppTheme() {
    return _singleton;
  }
  AppTheme._internal();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: kPrimary,
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: kPrimary),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: kPrimary,
        ),
      ),
    );
  }
}
