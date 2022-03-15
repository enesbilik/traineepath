import 'package:flutter/material.dart';

import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/utilities/utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? click;

  const CustomButton({
    Key? key,
    required this.text,
    this.icon,
    this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 12,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        height: 54,
        onPressed: click ?? () {},
        minWidth: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: Utils.dynamicFontSize(context, 16),
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
            icon != null
                ? Icon(
                    icon,
                    color: Colors.white,
                  )
                : const SizedBox(
                    width: 10,
                  ),
          ],
        ),
        color: kPrimary,
      ),
    );
  }
}
