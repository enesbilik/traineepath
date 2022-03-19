import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/base_view.dart';
import '../../constants/auth_data.dart';
import '../../constants/constants.dart';
import '../../models/users/user_model.dart';
import '../../route/route_manager.dart';
import '../../route/routes.dart';
import '../../services/firebase/auth_service.dart';
import '../../utilities/utils.dart';
import '../../widgets/customs/custom_button.dart';
import '../../widgets/customs/custom_loading_widget.dart';
import '../../widgets/customs/custom_text_field.dart';

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
                  ? const CustomLoading()
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
      style: kTextStyleBold.copyWith(fontSize: dynamicFontSize(22)),
    );
  }

  void _registerMethod() async {
    _changeLoading();
    try {
      var userCredential =
          await AuthService.register(widget.myUser, widget.password);

      if (userCredential != null) {
        RouteManager.navigatePageNamedRemove(
          context: context,
          routeName: AppRoute.LOGIN,
        );

        Utils.showSnackBar(
            context, "Kullanıcı başarılı bir şekilde oluşturuldu");
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
}
