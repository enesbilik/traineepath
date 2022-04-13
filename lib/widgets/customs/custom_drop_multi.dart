import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:trainee_path/constants/constants.dart';

import '../../base/base_state.dart';

class CustomDropMulti extends StatefulWidget {
  final List<String> items;
  final Function(List selectedItems) onSelected;
  final String hintText;
  const CustomDropMulti(
      {Key? key,
      required this.items,
      required this.onSelected,
      required this.hintText})
      : super(key: key);

  @override
  State<CustomDropMulti> createState() => _CustomDropMultiState();
}

class _CustomDropMultiState extends BaseState<CustomDropMulti> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: DropdownSearch<String>.multiSelection(
        showClearButton: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Ara',
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              gapPadding: 0,
            ),
          ),
        ),
        dropdownSearchDecoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            left: 18,
            top: 4,
            bottom: 8,
            right: 10,
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: dynamicFontSize(18),
            color: kHintTextColor.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
        ),
        maxHeight: dynamicHeight(0.5),
        showSearchBox: true,
        mode: Mode.BOTTOM_SHEET,
        items: widget.items,
        // ignore: deprecated_member_use
        hint: widget.hintText,
        onChanged: (value) {
          widget.onSelected(value);
        },
        //selectedItems: ["Brazil"],
      ),
    );
  }
}
