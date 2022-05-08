import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trainee_path/constants/constants.dart';

import '../../../base/base_state.dart';
import '../../../base/base_view.dart';
import '../../../widgets/avatar/on_board_circle.dart';
import '../model/on_board_model.dart';
import '../viewModel/on_board_view_model.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends BaseState<OnBoardView> {
  //TODO: mobx
  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardViewModel>(
      viewModel: OnBoardViewModel(),
      onModelReady: (OnBoardViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, OnBoardViewModel viewModel) =>
          Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: basePadding,
          child: Column(
            children: [
              const Spacer(flex: 1),
              Expanded(flex: 4, child: buildPageView(viewModel)),
              Expanded(child: _skipButton(viewModel)),
              Expanded(flex: 1, child: buildRowFooter(viewModel, context)),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _skipButton(OnBoardViewModel viewModel) {
    return TextButton(
      onPressed: () => viewModel.completeToOnBoard(),
      child: const Text(
        'Skip',
        style: TextStyle(
          fontSize: 15,
          color: kPrimary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  PageView buildPageView(OnBoardViewModel viewModel) {
    return PageView.builder(
        itemCount: viewModel.onBoardItems.length,
        onPageChanged: (value) {
          viewModel.changeCurrentIndex(value);
        },
        itemBuilder: (context, index) =>
            buildColumnBody(context, viewModel.onBoardItems[index]));
  }

  Row buildRowFooter(OnBoardViewModel viewModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildListViewCircles(viewModel),
      ],
    );
  }

  ListView buildListViewCircles(OnBoardViewModel viewModel) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Observer(builder: (_) {
          return OnBoardCircle(
            isSelected: viewModel.currentIndex == index,
          );
        });
      },
    );
  }

  Column buildColumnBody(BuildContext context, OnBoardModel model) {
    return Column(
      children: [
        Expanded(flex: 5, child: buildImage(model.imagePath)),
        const Spacer(flex: 1),
        buildColumnDescription(context, model),
      ],
    );
  }

  Widget buildColumnDescription(BuildContext context, OnBoardModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          buildAutoLocaleTextTitle(model, context),
          baseSpace3,
          buildAutoLocaleTextDescription(model, context)
        ],
      ),
    );
  }

  Widget buildAutoLocaleTextTitle(OnBoardModel model, BuildContext context) {
    return Text(
      model.title,
      textAlign: TextAlign.center,
      style: kTextStyleBold.copyWith(fontSize: 26, color: kPrimary),
    );
  }

  Widget buildAutoLocaleTextDescription(
      OnBoardModel model, BuildContext context) {
    return Text(
      model.title,
      textAlign: TextAlign.center,
      style: kTextStyleNormal.copyWith(fontSize: 18),
    );
  }

  Widget buildImage(String path) => Image.asset(path);

  SvgPicture buildSvgPicture(String path) => SvgPicture.asset(path);
}
