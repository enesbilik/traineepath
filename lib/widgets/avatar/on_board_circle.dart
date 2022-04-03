import 'package:flutter/material.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/extensions/context_extension.dart';

class OnBoardCircle extends StatelessWidget {
  final bool isSelected;

  const OnBoardCircle({Key? key, required this.isSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: CircleAvatar(
        backgroundColor: kPrimary.withOpacity(isSelected ? 1 : 0.2),
        radius: isSelected ? context.width * 0.013 : context.width * 0.01,
      ),
    );
  }
}
