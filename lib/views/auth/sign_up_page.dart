import 'package:flutter/material.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/auth_data.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/models/user_model.dart';
import 'package:trainee_path/services/firebase/auth_service.dart';
import 'package:trainee_path/validator/user_validate.dart';
import 'package:trainee_path/views/auth/let_sign_up_page.dart';
import 'package:trainee_path/widgets/custom_button.dart';
import 'package:trainee_path/widgets/custom_text_field.dart';
import 'package:trainee_path/widgets/custom_date_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends BaseAuthView<SignUpPage> with UserValidateMixin {
  late TextEditingController _nameEditingController;
  late TextEditingController _surnameEditingController;
  late TextEditingController _phoneNumberEditingController;
  late TextEditingController _mailEditingController;
  late TextEditingController _passwordEditingController;

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
          height: dynamicHeight(1),
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
              baseSpace,
              CustomTextField(
                hintText: AuthData.surnameText,
                keyboardType: TextInputType.name,
                controller: _surnameEditingController,
              ),
              baseSpace,
              CustomTextField(
                hintText: AuthData.numberText,
                keyboardType: TextInputType.phone,
                controller: _phoneNumberEditingController,
              ),
              baseSpace,
              CustomTextField(
                hintText: AuthData.mailText,
                keyboardType: TextInputType.emailAddress,
                controller: _mailEditingController,
              ),
              baseSpace,
              CustomTextField(
                hintText: AuthData.passwordText,
                controller: _passwordEditingController,
                keyboardType: TextInputType.visiblePassword,
                isObscure: true,
              ),
              baseSpace,
              const DatePickerPage(),
              const Spacer(flex: 3),
              CustomButton(
                text: AuthData.continueText,
                icon: Icons.arrow_forward_rounded,
                click: () async {
                  print(_nameEditingController.text);
                  var userModel = createUserModel();
                  var back = await AuthService.register(userModel, "password");
                  print(back!.user!.email);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const LetSignUpPage()),
                  // );
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

  UserModel createUserModel() {
    var nameResult = nameValidate(_nameEditingController.text);
    var surNameResult = nameValidate(_surnameEditingController.text);
    var phoneNumberResult = nameValidate(_phoneNumberEditingController.text);
    var passwordResult = nameValidate(_passwordEditingController.text);

    if (nameResult != null) print(nameResult);
    if (surNameResult != null) print(nameResult);
    if (phoneNumberResult != null) print(nameResult);
    if (passwordResult != null) print(nameResult);

    return UserModel(
      name: _nameEditingController.text,
      surName: _surnameEditingController.text,
      mail: _mailEditingController.text,
      phoneNumber: _phoneNumberEditingController.text,
      dateOfBirth: DateTime.now(),
    );
  }
}
