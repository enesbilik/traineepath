import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/constants/home_data.dart';
import 'package:trainee_path/models/contents/deparment_model.dart';
import 'package:trainee_path/widgets/custom_text_field.dart';
import 'package:trainee_path/widgets/deparment_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseViewState<HomePage> {
  CollectionReference departmentReference =
      FirebaseFirestore.instance.collection('DEPARTMENTS');
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
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
              onChanged: (value) {},
            ),
            //baseSpace3,
            departmentText,
            //baseSpace3,
            buildCards(),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildCards() {
    return StreamBuilder<QuerySnapshot>(
        stream: departmentReference.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List listOfDepartments = snapshot.data!.docs;

          return SizedBox(
            height: dynamicHeight(0.35),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listOfDepartments.length,
              itemBuilder: (BuildContext context, int index) {
                DepartmentModel department =
                    DepartmentModel.fromMap(listOfDepartments[index].data());
                return SizedBox(
                  width: dynamicHeight(0.32),
                  child: DeparmentCard(department: department),
                );
              },
            ),
          );
        });
  }

  Align get departmentText {
    return Align(
      child: Text(
        HomeData.departmentsText,
        style: kTextStyleBold.copyWith(fontSize: 20),
      ),
      alignment: Alignment.topLeft,
    );
  }

  Text get subTitle {
    return Text(
      HomeData.deparmentSearchText,
      style: kTextStyleNormal,
    );
  }

  Text get title {
    return Text(
      "${HomeData.helloText} Enes!",
      style: kTextStyleBold.copyWith(fontSize: 32),
    );
  }
}
