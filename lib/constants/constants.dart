import 'package:flutter/material.dart';

// Colors
const Color kPrimary = Color(0xff324595);
const Color kBackgroundColor = Color(0xffF3F5F9);
const Color kTextColor = Color(0xff344356);
const Color kHintTextColor = Color.fromRGBO(52, 67, 86, 0.6);

// Paths
const String logoPath = 'assets/icons/logo.png';

// Text Styles
const TextStyle kTextStyleBold = TextStyle(
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
final TextStyle kTextStyleNormal = TextStyle(
  color: kTextColor.withOpacity(0.8),
  fontWeight: FontWeight.w400,
);

final TextStyle kForgotPasswordStyle = TextStyle(
  color: kTextColor.withOpacity(0.5),
  fontWeight: FontWeight.w400,
  fontSize: 16,
  letterSpacing: 0.4,
);
