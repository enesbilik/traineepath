import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:trainee_path/base/base_auth_view.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/models/contents/subtopic_model.dart';
import 'package:trainee_path/models/contents/main_topic_model.dart';
import 'package:trainee_path/widgets/topic_card.dart';

class SubTopicPage extends StatefulWidget {
  final int id;
  const SubTopicPage({Key? key, required this.id}) : super(key: key);

  @override
  State<SubTopicPage> createState() => _SubTopicPageState();
}

class _SubTopicPageState extends BaseViewState<SubTopicPage> {
  late CollectionReference topicsReference;
  late CollectionReference subTopicsReference;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subTopicsReference =
        topicsReference.doc("jU7VJIAo2YOkCAHiguLo").collection("SUBTOPICS");
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: basePadding,
          child: Column(
            children: [
              buildTopics(),
              baseSpace1,
              buildSubTopics(subTopicsReference),
              // const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopics() {
    return StreamBuilder<QuerySnapshot>(
        stream: topicsReference.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List listOfTopics = snapshot.data!.docs;

          return SizedBox(
            height: dynamicHeight(0.22),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listOfTopics.length,
              itemBuilder: (BuildContext context, int index) {
                MainTopic topicModel =
                    MainTopic.fromMap(listOfTopics[index].data());
                return SizedBox(
                  width: dynamicHeight(0.19),
                  child: TopicCard(topicModel: topicModel),
                );
              },
            ),
          );
        });
  }

  Widget buildSubTopics(CollectionReference reference) {
    return Expanded(
      child: Card(
        child: StreamBuilder<QuerySnapshot>(
            stream: reference.snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List listOfSubTopics = snapshot.data!.docs;

              return ListView.separated(
                itemCount: listOfSubTopics.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(thickness: 0.7);
                },
                itemBuilder: (BuildContext context, int index) {
                  SubTopic topicModel =
                      SubTopic.fromMap(listOfSubTopics[index].data());

                  return ListTile(
                    onTap: () {},
                    title: Text(topicModel.title),
                    subtitle: Text(topicModel.subtitle),
                    leading: CircleAvatar(
                      child: Text(index.toString()),
                    ),
                  );
                },
              );
            }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
