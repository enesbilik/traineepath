import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trainee_path/views/auth/login_page.dart';
import 'package:trainee_path/views/auth/sign_up_page.dart';
import 'package:trainee_path/views/splash/splash_page.dart';
import 'package:trainee_path/views/tabs/main_page.dart';
import 'route/routes.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final bool isLogged = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TraineePath',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoute.SPLASH,
      routes: {
        AppRoute.MAIN: (context) => const MainPage(),
        AppRoute.LOGIN: (context) => const LoginPage(),
        AppRoute.SIGN: (context) => const SignUpPage(),
        AppRoute.SPLASH: (context) => const SplashPage(),
      },
    );
  }
}
