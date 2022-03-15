import 'package:flutter/material.dart';

class CustomVisibleColumn extends StatelessWidget {
  final List<Widget> children;
  final bool visible;
  final EdgeInsets padding;
  const CustomVisibleColumn(
      {Key? key,
      required this.children,
      required this.visible,
      this.padding = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Visibility(
        visible: visible,
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
