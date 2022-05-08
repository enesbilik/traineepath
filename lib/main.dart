import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trainee_path/views/auth/forgot_password_page.dart';

import 'route/navigation_service.dart';
import 'route/routes.dart';
import 'theme/app_theme.dart';
import 'views/auth/login_page.dart';
import 'views/auth/sign_up_page.dart';
import 'views/onboard/view/on_board_view.dart';
import 'views/splash/splash_page.dart';
import 'views/tabs/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: ForgotPasswordPage(),
      debugShowCheckedModeBanner: false,
      title: 'TraineePath',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoute.SPLASH,
      navigatorKey: NavigationService.instance.navigatorKey,
      routes: {
        AppRoute.MAIN: (context) => const MainPage(),
        AppRoute.LOGIN: (context) => const LoginPage(),
        AppRoute.SIGN: (context) => const SignUpPage(),
        AppRoute.SPLASH: (context) => const SplashPage(),
        AppRoute.ON_BOARD: (context) => const OnBoardView(),
        AppRoute.FORGOT: (context) => const ForgotPasswordPage(),
      },
    );
  }
}
