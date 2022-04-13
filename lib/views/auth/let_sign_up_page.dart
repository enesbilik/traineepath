import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/data/universities.dart';
import 'package:trainee_path/widgets/customs/custom_drop_multi.dart';
import 'package:trainee_path/widgets/customs/custom_drop_single.dart';

import '../../base/base_state.dart';
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

// ignore: must_be_immutable
class LetSignUpPage extends StatefulWidget {
  UserModel myUser;
  final String password;
  LetSignUpPage({Key? key, required this.myUser, required this.password})
      : super(key: key);

  @override
  _LetSignUpPageState createState() => _LetSignUpPageState();
}

class _LetSignUpPageState extends BaseState<LetSignUpPage> {
  bool _isLoading = false;
  late TextEditingController whichSchoolController;
  String? whichGradeController;
  List closingDepartments = [];
  List targetUniversities = [];

  @override
  void initState() {
    whichSchoolController = TextEditingController();
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
                hintText: AuthData.whichSchoolHintText,
                controller: whichSchoolController,
              ),
              baseSpace2,
              CustomDropSingle(
                hintText: AuthData.whichGradeHintText,
                items: DropItemService.grades,
                onSelected: (val) {
                  whichGradeController = val;
                },
              ),
              baseSpace2,
              CustomDropMulti(
                hintText: AuthData.closerDepartHintText,
                items: DropItemService.departments,
                onSelected: (val) {
                  closingDepartments = val;
                },
              ),
              baseSpace2,
              CustomDropMulti(
                hintText: AuthData.targetUniHintText,
                items: DropItemService.universities,
                onSelected: (val) {
                  targetUniversities = val;
                },
              ),
              const Spacer(),
              _isLoading
                  ? const CustomLoading()
                  : CustomButton(
                      text: AuthData.doneProfile, click: _registerMethod),
              SizedBox(height: dynamicHeight(0.15)),
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
    _assignUser();

    _changeLoading();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _assignUser() async {
    var resultOfValidate = _validateUserInfos();
    if (resultOfValidate != null) {
      Utils.showSnackBar(context, resultOfValidate);
      return;
    }
    _addLastUserInfo();
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
  }

  String? _validateUserInfos() {
    if (whichSchoolController.text.length <= 2) {
      return "Lütfen okul giriniz";
    } else if (whichGradeController == null) {
      return "Lütfen Sınıf Seçiniz!";
    } else if (closingDepartments.isEmpty) {
      return "Lütfen Bölüm seçiniz";
    } else if (targetUniversities.isEmpty) {
      return "Hedeflediğiniz üniversiteleri giriniz";
    }
    return null;
  }

  void _addLastUserInfo() {
    UserModel lastUser = widget.myUser.copyWith(
      studyingSchool: whichSchoolController.text,
      grade: whichGradeController,
      closingDeparments: closingDepartments,
      wantedUniversities: targetUniversities,
    );
    widget.myUser = lastUser;
    //print(widget.myUser);
  }
}
