import 'package:flutter/material.dart';

import '../../base/base_state.dart';
import '../../constants/auth_data.dart';
import '../../constants/constants.dart';
import '../../models/users/user_model.dart';
import '../../utilities/utils.dart';
import '../../widgets/customs/custom_button.dart';
import '../../widgets/customs/custom_text_field.dart';
import 'let_sign_up_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends BaseState<SignUpPage> {
  late TextEditingController _nameEditingController;
  late TextEditingController _surnameEditingController;
  late TextEditingController _phoneNumberEditingController;
  late TextEditingController _mailEditingController;
  late TextEditingController _passwordEditingController;
  late UserModel myUser;

  @override
  void initState() {
    _nameEditingController = TextEditingController();
    _surnameEditingController = TextEditingController();
    _phoneNumberEditingController = TextEditingController();
    _mailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: basePadding,
          height: dynamicHeight(0.95),
          width: dynamicWidth(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: dynamicHeight(0.07)),
              CustomTextField(
                hintText: AuthData.nameText,
                keyboardType: TextInputType.name,
                controller: _nameEditingController,
              ),
              baseSpace1,
              CustomTextField(
                hintText: AuthData.surnameText,
                keyboardType: TextInputType.name,
                controller: _surnameEditingController,
              ),
              baseSpace1,
              CustomTextField(
                hintText: AuthData.numberText,
                keyboardType: TextInputType.phone,
                controller: _phoneNumberEditingController,
              ),
              baseSpace1,
              CustomTextField(
                hintText: AuthData.mailText,
                keyboardType: TextInputType.emailAddress,
                controller: _mailEditingController,
              ),
              baseSpace1,
              CustomTextField(
                hintText: AuthData.passwordText,
                controller: _passwordEditingController,
                keyboardType: TextInputType.visiblePassword,
                isObscure: true,
              ),
              baseSpace1,
              //const DatePickerPage(),
              const Spacer(flex: 2),
              CustomButton(
                text: AuthData.continueText,
                icon: Icons.arrow_forward_rounded,
                click: _assignUser,
              ),
              SizedBox(
                height: dynamicHeight(0.1),
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
      style: kTextStyleBold.copyWith(fontSize: dynamicFontSize(22)),
    );
  }

  Widget _getSubText() {
    return Text(
      AuthData.createNewAccountSub,
      style: TextStyle(
        fontSize: dynamicFontSize(16),
        color: kTextColor,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }

  UserModel createUserModel() {
    return UserModel(
      name: _nameEditingController.text,
      surName: _surnameEditingController.text,
      mail: _mailEditingController.text,
      phoneNumber: _phoneNumberEditingController.text,
      dateOfBirth: DateTime.now(),
    );
  }

  void _assignUser() async {
    var resultOfValidate = _validateUserInfos();
    if (resultOfValidate != null) {
      Utils.showSnackBar(context, resultOfValidate);
      return;
    }
    myUser = createUserModel();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LetSignUpPage(
          myUser: myUser,
          password: _passwordEditingController.text,
        ),
      ),
    );
  }

  String? _validateUserInfos() {
    if (_nameEditingController.text.length <= 2) {
      return "Lütfen isim giriniz";
    } else if (_surnameEditingController.text.length <= 2) {
      return "Lütfen soyisim giriniz";
    } else if (_phoneNumberEditingController.text.length != 10) {
      return "Lütfen 10 haneli cep telefonu numaranızı giriniz";
    } else if (_mailEditingController.text.isEmpty ||
        !_mailEditingController.text.contains('@')) {
      return "Lütfen email adresinizi giriniz";
    } else if (_passwordEditingController.text.length < 6) {
      return "Parola en az 6 karakter olmalı";
    }
    return null;
  }
}
