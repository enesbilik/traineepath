import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../base/base_state.dart';
import '../../constants/auth_data.dart';
import '../../constants/constants.dart';
import '../../services/firebase/auth_service.dart';
import '../../utilities/utils.dart';
import '../../widgets/customs/custom_button.dart';
import '../../widgets/customs/custom_loading_widget.dart';
import '../../widgets/customs/custom_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends BaseState<ForgotPasswordPage> {
  final _firebaseAuth = AuthService();
  late TextEditingController _mailEditingController;
  bool _isLoading = false;

  @override
  void initState() {
    _mailEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _getLogo(),
              baseSpace2,
              _getTopText(),
              baseSpace2,
              CustomTextField(
                hintText: AuthData.mailText,
                keyboardType: TextInputType.emailAddress,
                controller: _mailEditingController,
              ),
              baseSpace2,
              _isLoading
                  ? const CustomLoading()
                  : CustomButton(
                      text: "Gönder",
                      click: () {
                        onTap();
                      },
                    ),
            ],
          ),
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
        "Şifrenizi sıfırlamak için e-posta adresinizi giriniz.",
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

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> onTap() async {
    _changeLoading();
    try {
      await _firebaseAuth.passwordReset(_mailEditingController.text);
      Navigator.pop(context);
      Utils.showSnackBar(context,
          "Şifre sıfırlama bağlantısı başarılı bir şekilde gönderildi");
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context, e.message.toString());
    }
    _changeLoading();
  }
}
