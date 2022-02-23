import 'package:flutter/material.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/constants/home_data.dart';
import 'package:trainee_path/models/contents/deparment_model.dart';
import 'package:trainee_path/services/http/department_service.dart';
import 'package:trainee_path/widgets/custom_text_field.dart';
import 'package:trainee_path/widgets/deparment_card.dart';
import 'package:trainee_path/widgets/loading_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseViewState<HomePage> {
  late TextEditingController searchController;
  late Future<List<DepartmentModel>> futureDepartments;

  @override
  void initState() {
    searchController = TextEditingController();
    futureDepartments = DepartmentService.fetchDepartments();

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
            buildDepartmentsCard(),

            //baseSpace3,
            //buildCards(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<DepartmentModel>> buildDepartmentsCard() {
    return FutureBuilder<List<DepartmentModel>>(
      future: futureDepartments,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: dynamicHeight(0.35),
            child: buildListView(snapshot),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        } else {
          return SizedBox(
            height: dynamicHeight(0.35),
            child: const CustomLoading(),
          );
        }
      },
    );
  }

  ListView buildListView(AsyncSnapshot<List<DepartmentModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: dynamicHeight(0.32),
          child: DeparmentCard(department: snapshot.data![index]),
        );
      },
    );
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
