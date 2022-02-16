import 'package:flutter/material.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/views/home/bookmark_page.dart';
import 'package:trainee_path/views/home/home_page.dart';
import 'package:trainee_path/views/home/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> tabs = [const HomePage(), const BookMark(), const ProfilePage()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _currentIndex,
        onTap: changeTap,
        items: bottomItems,
      ),
      backgroundColor: kBackgroundColor,
      body: tabs[_currentIndex],
    );
  }

  void changeTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> get bottomItems => const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Ana sayfa",
          activeIcon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline),
          label: "Kaydedilenler",
          activeIcon: Icon(Icons.bookmark),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profil",
          activeIcon: Icon(Icons.person),
        ),
      ];
}
