// To parse this JSON data, do
//
//     final stuCompMsgModel = stuCompMsgModelFromJson(jsonString);

import 'dart:convert';

StuCompMsgModel stuCompMsgModelFromJson(String str) => StuCompMsgModel.fromJson(json.decode(str));

String stuCompMsgModelToJson(ToStuCompMsgModel data) => json.encode(data.toJson());

class ToStuCompMsgModel {
  ToStuCompMsgModel({
    required this.studentId,
    required this.teacherId,
    required this.title,
    required this.message,
  });
  int studentId;
  int teacherId;
  String title;
  String message;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "teacher_id": teacherId,
    "title": title,
    "message": message,
  };
}

class StuCompMsgModel {
  StuCompMsgModel({
    required this.error,
    required this.status,
  });

  int error;
  String status;

  factory StuCompMsgModel.fromJson(Map<String, dynamic> json) => StuCompMsgModel(
    error: json["error"],
    status: json["status"],
  );
}
