import 'package:flutter/material.dart';
import 'package:trainee_path/constants/constants.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: kPrimary,
      ),
    );
  }
}
