// import 'package:drop_down_list/drop_down_list.dart';
// import 'package:flutter/material.dart';
// import 'package:trainee_path/constants/auth_data.dart';
// import 'package:trainee_path/constants/constants.dart';
// import 'package:trainee_path/models/university_model.dart';

// class CustomItemPicker extends StatefulWidget {
//   final String title;
//   final String hintText;
//   List<SelectedListItem>? dataList;
//   final bool isMultiple;
//   final void Function(List selectedItems) onSelectedList;
//   final Future<Object>? future;

//   CustomItemPicker({
//     Key? key,
//     required this.hintText,
//     required this.title,
//     this.dataList,
//     this.isMultiple = false,
//     required this.onSelectedList,
//     this.future,
//   }) : super(key: key);

//   @override
//   State<CustomItemPicker> createState() => _CustomItemPickerState();
// }

// class _CustomItemPickerState extends State<CustomItemPicker> {
//   List<dynamic> selectedItems = [];

//   final TextEditingController _searchTextEditingController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: Material(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         child: InkWell(
//           highlightColor: Colors.white70,
//           onTap: () {
//             onTextFieldTap(context);
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 19.0, right: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.hintText,
//                   style: TextStyle(
//                     color: kHintTextColor.withOpacity(0.5),
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down,
//                   color: kHintTextColor.withOpacity(0.7),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   buildDataList() async {
//     return FutureBuilder(
//       future: widget.future!,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           setState(() {
//             widget.dataList = snapshot.data
//                 .map((e) => UniversityModel.fromMap(snapshot.data[0]));
//           });
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   void onTextFieldTap(BuildContext context) {
//     DropDownState(
//       DropDown(
//         selectedItems: (List<dynamic> selecteds) {
//           widget.onSelectedList(selecteds);
//         },
//         submitButtonText: AuthData.doneText,
//         submitButtonColor: kPrimary,
//         bottomSheetTitle: widget.title,
//         searchBackgroundColor: Colors.black12,
//         // dataList: widget.dataList,
//         enableMultipleSelection: widget.isMultiple,
//         searchController: _searchTextEditingController,
//       ),
//     ).showModal(context);
//   }
// }
