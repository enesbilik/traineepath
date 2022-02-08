import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/auth_data.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/temp_data/universities.dart';
import 'package:trainee_path/widgets/custom_button.dart';
import 'package:trainee_path/widgets/custom_item_picker.dart';
import 'package:trainee_path/widgets/custom_text_field.dart';

class LetSignUpPage extends StatefulWidget {
  const LetSignUpPage({Key? key}) : super(key: key);

  @override
  _LetSignUpPageState createState() => _LetSignUpPageState();
}

class _LetSignUpPageState extends BaseAuthView<LetSignUpPage> {
  @override
  void initState() {
    super.initState();
    UniversityService.readJson();
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
              const CustomButton(text: AuthData.doneProfile),
              SizedBox(
                height: dynamicHeight(0.15),
              ),

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
}
