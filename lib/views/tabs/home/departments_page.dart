import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../base/base_state.dart';
import '../../../constants/constants.dart';
import '../../../constants/home_data.dart';
import '../../../models/contents/deparment_model.dart';
import '../../../models/users/user_model.dart';
import '../../../services/http/department_service.dart';
import '../../../widgets/cards/deparment_card.dart';
import '../../../widgets/customs/custom_loading_widget.dart';
import '../../../widgets/customs/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  late TextEditingController searchController;
  List<DepartmentModel> futureDepartments = [];
  List<DepartmentModel> filteredDepartments = [];
  String name = '';
  late UserModel newUser;
  var userDoc = FirebaseFirestore.instance
      .collection('USERS')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    searchController = TextEditingController();
    initUserData();

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            baseSpace3,
            title(name),
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
        child: Text("Bulunamadı.."),
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

  Text title(String name) {
    return Text(
      "${HomeData.helloText} $name!",
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

  Future<void> initUserData() async {
    var queryDoc = await userDoc.get();
    Map<String, dynamic>? data = queryDoc.data();
    if (data != null) {
      newUser = UserModel.fromMap(data);
      name = newUser.name;
    }
  }
}
