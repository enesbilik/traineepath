import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/views/tabs/home/subtopics_page.dart';
import 'package:trainee_path/views/tabs/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TraineePath',
      theme: theme,
      home: const SubTopicPage(),
    );
  }

  ThemeData get theme {
    return ThemeData(
      primaryColor: kPrimary,
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
