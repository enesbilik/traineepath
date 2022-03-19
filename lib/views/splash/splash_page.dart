import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/base_view.dart';
import '../../constants/pref_keys.dart';
import '../../route/route_manager.dart';
import '../../route/routes.dart';
import '../../widgets/customs/custom_loading_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseViewState<SplashPage> {
  late bool isLogged;

  @override
  void initState() {
    getLogged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomLoading(),
    );
  }

  Future getLogged() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final SharedPreferences pref = await SharedPreferences.getInstance();

    isLogged = pref.getBool(PrefKeys.ISLOGGED.toString()) ?? false;

    RouteManager.navigatePageNamedRemove(
      context: context,
      routeName: isLogged ? AppRoute.MAIN : AppRoute.LOGIN,
    );
  }
}



//TODO kullanıcıdan görüş bildirisi
