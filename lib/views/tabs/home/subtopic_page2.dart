// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// import 'package:trainee_path/base/base_auth_view.dart';
// import 'package:trainee_path/constants/constants.dart';
// import 'package:trainee_path/models/subtopic_model.dart';
// import 'package:trainee_path/models/topic_model.dart';
// import 'package:trainee_path/widgets/topic_card.dart';

// class SubTopicPage2 extends StatefulWidget {
//   final String id;
//   const SubTopicPage2({Key? key, required this.id}) : super(key: key);

//   @override
//   State<SubTopicPage2> createState() => _SubTopicPage2State();
// }

// class _SubTopicPage2State extends BaseViewState<SubTopicPage2> {
//   late CollectionReference topicsReference;
//   late CollectionReference subTopicsReference;
//   String id = 'jU7VJIAo2YOkCAHiguLo';

//   @override
//   void initState() {
//     setTopicRef();
//     setSubTopicRef();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       backgroundColor: kBackgroundColor,
//       body: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: basePadding,
//           child: StreamBuilder<QuerySnapshot>(
//             stream: topicsReference.snapshots(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return const Center(
//                   child: Text("No Data"),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               List listOfTopics = snapshot.data!.docs;
//               return Column(
//                 children: [
//                   buildTopics(listOfTopics),
//                   baseSpace1,
//                   buildSubTopics(subTopicsReference),
//                   // const SizedBox(height: 4),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTopics(List listOfTopics) {
//     return SizedBox(
//       height: dynamicHeight(0.22),
//       child: ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: listOfTopics.length,
//         itemBuilder: (BuildContext context, int index) {
//           TopicModel topicModel =
//               TopicModel.fromMap(listOfTopics[index].data());
//           return SizedBox(
//             width: dynamicHeight(0.19),
//             child: TopicCard(
//                 topicModel: topicModel,
//                 onTap: (value) {
//                   setState(() {
//                     print(value);
//                     id = value;
//                   });
//                 }),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildSubTopics(CollectionReference reference) {
//     if (id.isNotEmpty) {
//       subTopicsReference = topicsReference.doc(id).collection("SUBTOPICS");
//       return Expanded(
//         child: Card(
//           child: StreamBuilder<QuerySnapshot>(
//             stream: subTopicsReference.snapshots(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               List listOfSubTopics = snapshot.data!.docs;

//               return ListView.separated(
//                 itemCount: listOfSubTopics.length,
//                 separatorBuilder: (BuildContext context, int index) {
//                   return const Divider(thickness: 0.7);
//                 },
//                 itemBuilder: (BuildContext context, int index) {
//                   SubTopicModel topicModel =
//                       SubTopicModel.fromMap(listOfSubTopics[index].data());

//                   return ListTile(
//                     onTap: () {},
//                     title: Text(topicModel.title),
//                     subtitle: Text(topicModel.subtitle),
//                     leading: CircleAvatar(
//                       child: Text(index.toString()),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         ),
//       );
//     } else {
//       return Expanded(
//         child: Card(),
//       );
//     }
//   }

//   void setTopicRef() {
//     topicsReference = FirebaseFirestore.instance
//         .collection('DEPARTMENTS')
//         .doc(widget.id)
//         .collection("TOPICS");
//   }

//   void setSubTopicRef() {
//     subTopicsReference =
//         topicsReference.doc("jU7VJIAo2YOkCAHiguLo").collection("SUBTOPICS");
//   }
// }
