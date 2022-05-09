import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../base/base_state.dart';
import '../../../constants/constants.dart';
import '../../../models/contents/main_topic_model.dart';
import '../../../models/contents/subtopic_model.dart';
import '../../../services/http/main_topic_service.dart';
import '../../../widgets/cards/topic_card.dart';
import '../../../widgets/customs/custom_loading_widget.dart';
import '../home/content_page.dart';

class BookMark extends StatefulWidget {
  const BookMark({
    Key? key,
  }) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends BaseState<BookMark> {
  final double _circular = 20;
  List<MainTopic> filteredTopics = [];
  List savedTopics = [];
  int _selectedIndex = 0;

  final userDoc = FirebaseFirestore.instance
      .collection('USERS')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    initSavedTopic();
    MainTopicService.fetchTopics().then((data) {
      _topicsFilter(data);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: basePadding,
          child: Column(
            children: [
              baseSpace1,
              buildTopicsCard(),
              baseSpace0,
              buildSubTopics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopicsCard() {
    return SizedBox(
      height: dynamicHeight(0.22),
      child:
          filteredTopics.isNotEmpty ? buildListView() : const CustomLoading(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: filteredTopics.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: dynamicHeight(0.19),
          child: TopicCard(
            mainTopic: filteredTopics[index],
            index: index,
            click: (value) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }

  void _topicsFilter(List<MainTopic> data) {
    return setState(() {
      filteredTopics = data.where((mainTopic) {
        return savedTopics.contains(mainTopic.id);
      }).toList();
    });
  }

  Widget buildSubTopics() {
    return Expanded(
      child: Card(
        child: ListView.separated(
          itemCount: filteredTopics.isNotEmpty
              ? filteredTopics[_selectedIndex].subTopics.length
              : 0,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(thickness: 0.7);
          },
          itemBuilder: (BuildContext context, int index) {
            SubTopic subTopic = filteredTopics[_selectedIndex].subTopics[index];

            return buildListItem(subTopic, index);
          },
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_circular)),
      ),
    );
  }

  ListTile buildListItem(SubTopic subTopic, int index) {
    return ListTile(
      onTap: () => _navigateContent(subTopic),
      title: Text(subTopic.title),
      subtitle: Text(subTopic.subtitle),
      leading: CircleAvatar(
        backgroundColor: kPrimary,
        child: Text((++index).toString()),
      ),
    );
  }

  void _navigateContent(SubTopic subTopic) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContentPage(content: subTopic.content)));
  }

  void initSavedTopic() {
    userDoc.get().then((value) {
      setState(() {
        savedTopics = value.data()!['savedTopics'];
      });
    });
  }
}
