// To parse this JSON data, do
//
//     final stuUpdateCounter = stuUpdateCounterFromJson(jsonString);

import 'dart:convert';

String stuUpdateCounterToJson(ToStuUpdateCounterModel data) => json.encode(data.toJson());

class ToStuUpdateCounterModel {
  ToStuUpdateCounterModel({
    required this.studentId,
    required this.type,
  });
  int studentId;
  String type;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "type": type,
  };
}