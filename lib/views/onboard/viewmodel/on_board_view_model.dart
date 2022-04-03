import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:trainee_path/route/routes.dart';

import '../../../base/base_view_model.dart';
import '../../../constants/pref_keys.dart';
import '../model/on_board_model.dart';

part 'on_board_view_model.g.dart';

class OnBoardViewModel = _OnBoardViewModelBase with _$OnBoardViewModel;

abstract class _OnBoardViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  List<OnBoardModel> onBoardItems = [];

  @observable
  int currentIndex = 0;

  @action
  void changeCurrentIndex(int value) {
    currentIndex = value;
  }

  @override
  void init() {
    onBoardItems.add(
      OnBoardModel(
        'Meslek seçimi hayatındaki en önemli kararlardan biri',
        'Kafanın karışık olduğu bir konu olabilir, ancak TraineePath yanında',
        'assets/images/on_board1.png',
      ),
    );
    onBoardItems.add(
      OnBoardModel(
        'Programları deneyimleyerek keşfet!',
        'Her bölüme özel yapıda olan adımları yaşayarak, program içeriklerini öğren.',
        'assets/images/on_board2.png',
      ),
    );
    onBoardItems.add(
      OnBoardModel(
        'TraineePath1',
        'Deneyimlediğin mesleği ileri taşıyan ilham veren kişileri ve olayları keşfet! ',
        'assets/images/on_board3.png',
      ),
    );
  }

  Future<void> completeToOnBoard() async {
    await localeManager.setBoolValue(PreferencesKeys.IS_FIRST_APP, false);
    var deneme = localeManager.getBoolValue(PreferencesKeys.IS_FIRST_APP);
    print(deneme);
    if (navigation.navigatorKey.currentState!.canPop()) {
      navigation.navigatorKey.currentState!.pop();
    } else {
      await navigation.navigateToPageClear(path: AppRoute.LOGIN);
    }
  }
}
