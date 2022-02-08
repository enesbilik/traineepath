import 'package:flutter/material.dart';

import 'package:trainee_path/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final TextInputType keyboardType;
  final IconData? icon;

  const CustomTextField({
    Key? key,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: isObscure,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          suffixIcon: icon != null ? Icon(icon) : null,
          suffixIconColor: kHintTextColor.withOpacity(0.3),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: kHintTextColor.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
