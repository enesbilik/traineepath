import 'package:flutter/material.dart';
import 'package:trainee_path/base/base_view.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/constants/home_data.dart';
import 'package:trainee_path/models/contents/deparment_model.dart';
import 'package:trainee_path/services/http/department_service.dart';
import 'package:trainee_path/widgets/customs/custom_text_field.dart';
import 'package:trainee_path/widgets/cards/deparment_card.dart';
import 'package:trainee_path/widgets/customs/custom_loading_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseViewState<HomePage> {
  late TextEditingController searchController;
  List<DepartmentModel> futureDepartments = [];
  List<DepartmentModel> filteredDepartments = [];

  @override
  void initState() {
    searchController = TextEditingController();
    initData();

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: dynamicWidth(1),
        height: dynamicHeight(0.9),
        padding: basePadding,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            baseSpace3,
            title,
            //baseSpace1,
            subTitle,
            //baseSpace3,
            CustomTextField(
              icon: Icons.search,
              hintText: HomeData.searchHint,
              controller: searchController,
              onChanged: (value) {
                _filterDepartments(value);
              },
            ),
            //baseSpace3,
            departmentText,
            buildDepartmentsCard(),

            //baseSpace3,
          ],
        ),
      ),
    );
  }

  Widget buildDepartmentsCard() {
    return SizedBox(
      height: dynamicHeight(0.35),
      child: currentWidget,
    );
  }

  Widget get currentWidget {
    if (filteredDepartments.isNotEmpty) {
      return buildListView();
    } else if (isSerching && filteredDepartments.isEmpty) {
      return const Center(
        child: Text("Not Found"),
      );
    } else {
      return const CustomLoading();
    }
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: filteredDepartments.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: dynamicHeight(0.32),
          child: DeparmentCard(department: filteredDepartments[index]),
        );
      },
    );
  }

  Align get departmentText {
    return Align(
      child: Text(
        HomeData.departmentsText,
        style: kTextStyleBold.copyWith(fontSize: dynamicFontSize(20)),
      ),
      alignment: Alignment.topLeft,
    );
  }

  Text get subTitle {
    return Text(
      HomeData.deparmentSearchText,
      style: kTextStyleNormal.copyWith(fontSize: dynamicFontSize(22)),
    );
  }

  Text get title {
    return Text(
      "${HomeData.helloText} Enes!",
      style: kTextStyleBold.copyWith(fontSize: dynamicFontSize(32)),
    );
  }

  void _filterDepartments(value) {
    setState(() {
      filteredDepartments = futureDepartments
          .where((department) =>
              department.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  bool get isSerching => searchController.text.isNotEmpty;
  void initData() {
    DepartmentService.fetchDepartments().then((data) {
      setState(() {
        futureDepartments = filteredDepartments = data;
      });
    });
  }
}
