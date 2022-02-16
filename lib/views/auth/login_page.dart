import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/auth_data.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/services/firebase/auth_service.dart';
import 'package:trainee_path/utilities/utils.dart';
import 'package:trainee_path/views/auth/sign_up_page.dart';
import 'package:trainee_path/widgets/custom_button.dart';
import 'package:trainee_path/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseAuthView<LoginPage> {
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
              baseSpace,
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
              baseSpace,
              CustomTextField(
                hintText: AuthData.passwordText,
                keyboardType: TextInputType.visiblePassword,
                isObscure: true,
                controller: _passwordEditingController,
              ),
              const SizedBox(height: 2),
              _getForgotPasswordButton(),
              const Spacer(flex: 3),
              _isLoading
                  ? const CircularProgressIndicator()
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
          style: kForgotPasswordStyle,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpPage()));
          },
          child: Text(
            AuthData.dontHaveAnAccountButton,
            style: kTextStyleBold.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _getForgotPasswordButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          AuthData.forgotPasswordText,
          style: kForgotPasswordStyle,
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
        style: kTextStyleNormal,
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
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const Scaffold(
                      body: Center(
                        child: Text("New Page"),
                      ),
                    )),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context, e.message.toString());
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(e.message.toString())));
    }
    _changeLoading();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
}
