import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/base_state.dart';
import '../../../constants/constants.dart';
import '../../../constants/pref_keys.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingButton(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      backgroundColor: kBackgroundColor,
      body: _buildBody(),
    );
  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      tooltip: 'Edit Profile',
      backgroundColor: kPrimary,
      onPressed: () {},
      child: const Icon(Icons.edit),
    );
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circleAvatar,
            baseSpace1,
            _name,
            baseSpace1,
            _dailyText,
            baseSpace2,
            _buildIconText(
              'assets/icons/school-solid.svg',
              'Beşiktaş Anadolu Lisesi',
            ),
            baseSpace1,
            _buildIconText(
              'assets/icons/graduation-cap-solid.svg',
              '12. Sınıf',
            ),
            baseSpace2,
            _getTargetButtons(),
          ],
        ),
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
            setLoginState();
          },
          icon: const Icon(
            Icons.settings,
          ),
          tooltip: 'Edit Profile',
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
      "Antonio Perez",
      style: TextStyle(fontSize: dynamicFontSize(50), color: kTextColor),
    );
  }

  CircleAvatar get _circleAvatar {
    return CircleAvatar(
      radius: dynamicWidth(0.20),
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundColor: kPrimary.withOpacity(0.9),
        radius: dynamicWidth(0.17),
      ),
    );
  }

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
}
