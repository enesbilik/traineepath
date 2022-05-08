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
  final List? savedTopics;
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
    this.savedTopics,
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
    List? savedTopics,
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
      savedTopics: savedTopics ?? this.savedTopics,
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
      'savedTopics': savedTopics,
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
      savedTopics: List.from(map['savedTopics']),
      closingDeparments: List.from(map['closingDeparments']),
      wantedUniversities: List.from(map['wantedUniversities']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, surName: $surName, mail: $mail, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, studyingSchool: $studyingSchool, grade: $grade, savedTopics: $savedTopics, closingDeparments: $closingDeparments, wantedUniversities: $wantedUniversities)';
  }
}
