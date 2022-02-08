import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/auth_data.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/views/auth/let_sign_up_page.dart';
import 'package:trainee_path/widgets/custom_button.dart';
import 'package:trainee_path/widgets/custom_text_field.dart';
import 'package:trainee_path/widgets/custom_date_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends BaseAuthView<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: basePadding,
          height: dynamicHeight(1),
          width: dynamicWidth(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: dynamicHeight(0.07)),
              const CustomTextField(
                hintText: AuthData.nameText,
                keyboardType: TextInputType.name,
              ),
              baseSpace,
              const CustomTextField(
                hintText: AuthData.surnameText,
                keyboardType: TextInputType.name,
              ),
              baseSpace,
              const CustomTextField(
                hintText: AuthData.numberText,
                keyboardType: TextInputType.phone,
              ),
              baseSpace,
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
              baseSpace,
              const DatePickerPage(),
              const Spacer(flex: 3),
              CustomButton(
                text: AuthData.continueText,
                icon: Icons.arrow_forward_rounded,
                click: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LetSignUpPage()),
                  );
                },
              ),
              SizedBox(
                height: dynamicHeight(0.15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Column(
        children: [
          _getTopText(),
          const SizedBox(height: 6),
          _getSubText(),
        ],
      ),
    );
  }

  Text _getTopText() {
    return Text(
      AuthData.createNewAccount,
      style: kTextStyleBold.copyWith(fontSize: 22),
    );
  }

  Widget _getSubText() {
    return const Text(
      AuthData.createNewAccountSub,
      style: TextStyle(
        fontSize: 16,
        color: kTextColor,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }
}
