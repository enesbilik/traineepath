import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainee_path/constants/auth_data.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/utilities/utils.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({Key? key}) : super(key: key);

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Utils.showSheet(
                context,
                child: buildDatePicker(),
                onClicked: () {
                  Navigator.pop(context);
                },
              );
            },
            child: Row(
              children: [
                Text(
                  AuthData.birthDayText + ' :',
                  style: kTextStyleNormal.copyWith(
                    fontSize: 16,
                    color: kTextColor,
                  ),
                ),
                Text(
                  " ${DateFormat('dd/MM/yyyy').format(dateTime)}",
                  style: kTextStyleNormal,
                ),
              ],
            ),
          ),
          /*
          ButtonWidget(
            onClicked: () => 
          ),*/
        ],
      ),
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          minimumYear: 1900,
          maximumDate: DateTime.now(),
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
}
