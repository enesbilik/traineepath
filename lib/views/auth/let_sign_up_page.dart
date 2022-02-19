import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/auth_data.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/models/user_model.dart';
import 'package:trainee_path/services/firebase/auth_service.dart';
import 'package:trainee_path/utilities/utils.dart';
import 'package:trainee_path/views/auth/login_page.dart';
import 'package:trainee_path/widgets/custom_button.dart';
import 'package:trainee_path/widgets/custom_text_field.dart';

class LetSignUpPage extends StatefulWidget {
  final UserModel myUser;
  final String password;
  const LetSignUpPage({Key? key, required this.myUser, required this.password})
      : super(key: key);

  @override
  _LetSignUpPageState createState() => _LetSignUpPageState();
}

class _LetSignUpPageState extends BaseViewState<LetSignUpPage> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    // UniversityService.readJson();
  }

  List temp = [];

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
                hintText: AuthData.whichSchoolHintText,
              ),
              baseSpace2,
              const CustomTextField(
                hintText: AuthData.whichGradeHintText,
              ),
              baseSpace2,
              const CustomTextField(
                hintText: AuthData.whichChooseText,
              ),
              baseSpace2,
              // CustomItemPicker(
              //   isMultiple: true,
              //   hintText: AuthData.closerDepartHintText,
              //   title: AuthData.titleDepartments,
              //   dataList: UniversityService.universities,
              //   onSelectedList: (temp) {},
              // ),
              // baseSpace2,
              // CustomItemPicker(
              //   isMultiple: true,
              //   hintText: AuthData.targetUniHintText,
              //   title: AuthData.titleUniversities,
              //   dataList: UniversityService.universities,
              //   onSelectedList: (temp) {},
              // ),
              baseSpace2,
              const Spacer(),
              _isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: AuthData.doneProfile, click: _registerMethod),
              SizedBox(height: dynamicHeight(0.15)),

              /* CustomItemPicker(
                dataList: UniversityService.universities,
                title: AuthData.whichSchoolHintText,
                isMultiple: true,
                onSelectedList: (selected) {
                  temp = selected;
                },
              ), */
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        children: [
          _getTopText(),
        ],
      ),
    );
  }

  Text _getTopText() {
    return Text(
      AuthData.knowYouText,
      style: kTextStyleBold.copyWith(fontSize: 22),
    );
  }

  void _registerMethod() async {
    _changeLoading();
    try {
      var userCredential =
          await AuthService.register(widget.myUser, widget.password);

      if (userCredential != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        Utils.showSnackBar(
            context, "Kullanıcı başarılı bir şekilde oluşturuldu");
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
