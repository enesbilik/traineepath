import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/auth_data.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/services/firebase/auth_service.dart';
import 'package:trainee_path/views/auth/sign_up_page.dart';
import 'package:trainee_path/widgets/custom_button.dart';
import 'package:trainee_path/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseAuthView<LoginPage> {
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
              const CustomTextField(
                hintText: AuthData.mailText,
                keyboardType: TextInputType.emailAddress,
              ),
              baseSpace,
              const CustomTextField(
                hintText: AuthData.passwordText,
                keyboardType: TextInputType.visiblePassword,
                isObscure: true,
              ),
              const SizedBox(height: 2),
              _getForgotPasswordButton(),
              const Spacer(flex: 3),
              const CustomButton(text: AuthData.logInText),
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
}
