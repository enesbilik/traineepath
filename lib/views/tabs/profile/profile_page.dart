import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainee_path/widgets/customs/custom_loading_widget.dart';

import '../../../base/base_state.dart';
import '../../../constants/constants.dart';
import '../../../constants/pref_keys.dart';
import '../../../models/users/user_model.dart';
import '../../../route/route_manager.dart';
import '../../../route/routes.dart';
import '../../../services/firebase/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfilePage> {
  int _selectedButton = 0;
  late UserModel newUser;
  bool _isLoading = false;

  var userDoc = FirebaseFirestore.instance
      .collection('USERS')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    initUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: _floatingButton(),
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      appBar: _appBar(),
      backgroundColor: kBackgroundColor,
      body: _isLoading == true ? const CustomLoading() : _buildBody(),
    );
  }

  // FloatingActionButton _floatingButton() {
  //   return FloatingActionButton(
  //     tooltip: 'Edit Profile',
  //     backgroundColor: kPrimary,
  //     onPressed: () {},
  //     child: const Icon(Icons.edit),
  //   );
  // }

  void setLoginState() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(PreferencesKeys.ISLOGGED.toString(), false);
    AuthService().signOut();
    RouteManager.navigatePageNamedRemove(
        context: context, routeName: AppRoute.LOGIN);
  }

  Widget _buildBody() {
    return Padding(
      padding: basePadding,
      child: Center(
        child: Column(
          children: [
            //_circleAvatar,
            baseSpace1,
            _name,
            baseSpace1,
            _mail,
            baseSpace1,
            _dailyText,
            baseSpace2,
            _buildIconText(
              'assets/icons/school-solid.svg',
              '${newUser.studyingSchool}',
            ),
            baseSpace1,
            _buildIconText(
              'assets/icons/graduation-cap-solid.svg',
              userGrade,
            ),
            baseSpace2,
            _getTargetButtons(),
            baseSpace1,
            buildTargetList(_selectedButton),
          ],
        ),
      ),
    );
  }

  Expanded buildTargetList(int selectedIndex) {
    var newList = selectedIndex == 0
        ? newUser.wantedUniversities
        : newUser.closingDeparments;
    return Expanded(
      child: ListView.builder(
        itemCount: newList!.length,
        itemBuilder: (BuildContext context, int index) {
          var school = newList[index];
          return Card(
            child: ListTile(
              title: Text(school),
            ),
          );
        },
      ),
    );
  }

  Row _getTargetButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTargetButton("Hedef\nÜniversiteler", 0),
        _buildTargetButton("Hedef\nBölümler", 1),
      ],
    );
  }

  MaterialButton _buildTargetButton(String text, int id) {
    bool _isSelected = _selectedButton == id;
    return MaterialButton(
      shape: getMaterialShape(id),
      padding: const EdgeInsets.all(12),
      minWidth: dynamicWidth(0.39),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: dynamicFontSize(17),
          fontWeight: _isSelected ? FontWeight.bold : FontWeight.w300,
        ),
      ),
      color: Colors.white,
      onPressed: () {
        setState(() {
          _selectedButton = id;
        });
      },
    );
  }

  RoundedRectangleBorder getMaterialShape(int id) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        left: id == 0 ? const Radius.circular(8) : const Radius.circular(0),
        right: id == 1 ? const Radius.circular(8) : const Radius.circular(0),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            exitSureDialog();

            // setLoginState();
          },
          icon: const Icon(
            Icons.exit_to_app,
          ),
          tooltip: 'Exit',
        )
      ],
    );
  }

  Text get _dailyText {
    return Text(
      "Hedeflerine Bir Adım Daha Yaklaş",
      style: TextStyle(fontSize: dynamicFontSize(20), color: kTextColor),
    );
  }

  Text get _name {
    return Text(
      "${newUser.name} ${newUser.surName}",
      style: TextStyle(fontSize: dynamicFontSize(34), color: kTextColor),
    );
  }

  Text get _mail {
    return Text(
      newUser.mail,
      style: TextStyle(fontSize: dynamicFontSize(20), color: kTextColor),
    );
  }

  // CircleAvatar get _circleAvatar {
  //   return CircleAvatar(
  //     radius: dynamicWidth(0.20),
  //     backgroundColor: Colors.white,
  //     child: CircleAvatar(
  //       backgroundColor: kPrimary.withOpacity(0.9),
  //       radius: dynamicWidth(0.17),
  //     ),
  //   );
  // }

  Row _buildIconText(String iconPath, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(iconPath, height: 26),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: dynamicFontSize(18)),
        ),
      ],
    );
  }

  Future<void> initUserData() async {
    _changeLoading();
    var queryDoc = await userDoc.get();
    Map<String, dynamic>? data = queryDoc.data();

    if (data != null) {
      setState(() {
        newUser = UserModel.fromMap(data);
      });
      _changeLoading();
    }
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  String get userGrade {
    String grade = newUser.grade!;
    int? isNum = int.tryParse(grade);

    return isNum == null ? "${newUser.grade}" : "${newUser.grade} .Sınıf";
  }

  void exitSureDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Çıkış yapmak istediğine emin misin?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => setLoginState(),
            child: const Text('Devam'),
          ),
        ],
      ),
    );
  }
}
