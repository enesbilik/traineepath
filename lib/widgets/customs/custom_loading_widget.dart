import 'package:flutter/material.dart';
import 'package:trainee_path/constants/constants.dart';

class CustomLoading extends StatelessWidget {
  final Color color;
  const CustomLoading({Key? key, this.color = kPrimary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
