import 'package:flutter/material.dart';
import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/models/contents/deparment_model.dart';
import 'package:trainee_path/models/contents/main_topic_model.dart';
import 'package:trainee_path/services/http/main_topic_service.dart';
import 'package:trainee_path/widgets/loading_widget.dart';
import 'package:trainee_path/widgets/topic_card.dart';

class MainTopicsPage extends StatefulWidget {
  final DepartmentModel departmentModel;
  const MainTopicsPage({Key? key, required this.departmentModel})
      : super(key: key);

  @override
  State<MainTopicsPage> createState() => _MainTopicsPageState();
}

class _MainTopicsPageState extends BaseViewState<MainTopicsPage> {
  late Future<List<MainTopic>> futureTopics;

  @override
  void initState() {
    futureTopics = MainTopicService.fetchTopics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: basePadding,
          child: Column(
            children: [
              buildTopicsCard(),
              // const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<MainTopic>> buildTopicsCard() {
    return FutureBuilder<List<MainTopic>>(
      future: futureTopics,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: dynamicHeight(0.22),
            child: buildListView(snapshot),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        } else {
          return SizedBox(
            height: dynamicHeight(0.22),
            child: const CustomLoading(),
          );
        }
      },
    );
  }

  ListView buildListView(AsyncSnapshot<List<MainTopic>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: dynamicHeight(0.19),
          child: TopicCard(topicModel: snapshot.data![index]),
        );
      },
    );
  }
}
