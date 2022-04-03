import 'package:flutter/material.dart';
import 'package:trainee_path/route/navigation_service.dart';

import '../../init/cache/locale_manager.dart';

abstract class BaseViewModel {
  BuildContext? context;

  LocaleManager localeManager = LocaleManager.instance;
  NavigationService navigation = NavigationService.instance;

  void setContext(BuildContext context);
  void init();
}
