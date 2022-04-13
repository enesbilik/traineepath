import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String? userId;
  final String name;
  final String surName;
  final String mail;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String? studyingSchool;
  final String? grade;
  final String? wantedDepartment;
  final List? closingDeparments;
  final List? wantedUniversities;
  UserModel({
    this.userId,
    required this.name,
    required this.surName,
    required this.mail,
    required this.phoneNumber,
    required this.dateOfBirth,
    this.studyingSchool,
    this.grade,
    this.wantedDepartment,
    this.closingDeparments,
    this.wantedUniversities,
  });

  UserModel copyWith({
    String? userId,
    String? name,
    String? surName,
    String? mail,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? studyingSchool,
    String? grade,
    String? wantedDepartment,
    List? closingDeparments,
    List? wantedUniversities,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      surName: surName ?? this.surName,
      mail: mail ?? this.mail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      studyingSchool: studyingSchool ?? this.studyingSchool,
      grade: grade ?? this.grade,
      wantedDepartment: wantedDepartment ?? this.wantedDepartment,
      closingDeparments: closingDeparments ?? this.closingDeparments,
      wantedUniversities: wantedUniversities ?? this.wantedUniversities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'surName': surName,
      'mail': mail,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'studyingSchool': studyingSchool,
      'grade': grade,
      'wantedDepartment': wantedDepartment,
      'closingDeparments': closingDeparments,
      'wantedUniversities': wantedUniversities,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      surName: map['surName'] ?? '',
      mail: map['mail'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      dateOfBirth: DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth']),
      studyingSchool: map['studyingSchool'] ?? '',
      grade: map['grade'] ?? '',
      wantedDepartment: map['wantedDepartment'] ?? '',
      closingDeparments: List.from(map['closingDeparments']),
      wantedUniversities: List.from(map['wantedUniversities']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, surName: $surName, mail: $mail, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, studyingSchool: $studyingSchool, grade: $grade, wantedDepartment: $wantedDepartment, closingDeparments: $closingDeparments, wantedUniversities: $wantedUniversities)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.name == name &&
        other.surName == surName &&
        other.mail == mail &&
        other.phoneNumber == phoneNumber &&
        other.dateOfBirth == dateOfBirth &&
        other.studyingSchool == studyingSchool &&
        other.grade == grade &&
        other.wantedDepartment == wantedDepartment &&
        listEquals(other.closingDeparments, closingDeparments) &&
        listEquals(other.wantedUniversities, wantedUniversities);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        surName.hashCode ^
        mail.hashCode ^
        phoneNumber.hashCode ^
        dateOfBirth.hashCode ^
        studyingSchool.hashCode ^
        grade.hashCode ^
        wantedDepartment.hashCode ^
        closingDeparments.hashCode ^
        wantedUniversities.hashCode;
  }
}
