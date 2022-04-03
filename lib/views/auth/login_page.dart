import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/base_state.dart';
import '../../constants/auth_data.dart';
import '../../constants/constants.dart';
import '../../constants/pref_keys.dart';
import '../../route/route_manager.dart';
import '../../route/routes.dart';
import '../../services/firebase/auth_service.dart';
import '../../utilities/utils.dart';
import '../../widgets/customs/custom_button.dart';
import '../../widgets/customs/custom_loading_widget.dart';
import '../../widgets/customs/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  final _firebaseAuth = AuthService();
  late TextEditingController _mailEditingController;
  late TextEditingController _passwordEditingController;
  bool _isLoading = false;

  @override
  void initState() {
    _mailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: dynamicHeight(1),
          width: dynamicWidth(1),
          padding: basePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              baseSpace1,
              const Spacer(flex: 1),
              _getLogo(),
              const Spacer(flex: 1),
              _getTopText(),
              const Spacer(flex: 1),
              CustomTextField(
                hintText: AuthData.mailText,
                keyboardType: TextInputType.emailAddress,
                controller: _mailEditingController,
              ),
              baseSpace1,
              CustomTextField(
                hintText: AuthData.passwordText,
                keyboardType: TextInputType.visiblePassword,
                isObscure: true,
                controller: _passwordEditingController,
              ),
              const SizedBox(height: 2),
              _getForgotPasswordButton(context),
              const Spacer(flex: 3),
              _isLoading
                  ? const CustomLoading()
                  : CustomButton(
                      text: AuthData.logInText,
                      click: _signInMethod,
                    ),
              _getSignUpTexts(),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  Row _getSignUpTexts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AuthData.dontHaveAnAccount,
          style: kForgotPasswordStyle.copyWith(fontSize: dynamicFontSize(16)),
        ),
        TextButton(
          onPressed: () {
            RouteManager.navigatePageNamed(context, AppRoute.SIGN);
          },
          child: Text(
            AuthData.dontHaveAnAccountButton,
            style: kTextStyleBold.copyWith(fontSize: dynamicFontSize(16)),
          ),
        ),
      ],
    );
  }

  Widget _getForgotPasswordButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          AuthData.forgotPasswordText,
          style: kForgotPasswordStyle.copyWith(
              fontSize: Utils.dynamicFontSize(context, 16)),
        ),
      ),
    );
  }

  Padding _getTopText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 40,
      ),
      child: Text(
        AuthData.topText,
        style: kTextStyleNormal.copyWith(fontSize: dynamicFontSize(22)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Center _getLogo() {
    return Center(
      child: Image.asset(logoPath),
    );
  }

  AppBar _appBar() {
    return AppBar();
  }

  void _signInMethod() async {
    _changeLoading();
    try {
      var userCredential = await _firebaseAuth.signIn(
          _mailEditingController.text, _passwordEditingController.text);

      if (userCredential != null) {
        setLoginState();

        RouteManager.navigatePageNamedRemove(
          context: context,
          routeName: AppRoute.MAIN,
        );
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context, e.message.toString());
    }
    _changeLoading();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void setLoginState() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(PreferencesKeys.ISLOGGED.toString(), true);
  }
}
