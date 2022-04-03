import 'package:flutter/material.dart';

class Deneme extends StatelessWidget {
  const Deneme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String unies = "'ytu', 'medipol', 'itü'";

    unies += ",'istanbul'";

    unies.replaceAll('"', '');

    var newList = unies.split(",");

    print(newList);

    newList.remove('ytu');

    print(newList);

    return Scaffold();
  }
}
