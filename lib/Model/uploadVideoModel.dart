// To parse this JSON data, do
//
//     final stuCompMsgModel = stuCompMsgModelFromJson(jsonString);

import 'dart:convert';

UploadVideoModel uploadVideoModelFromJson(String str) => UploadVideoModel.fromJson(json.decode(str));

String uploadVideoModelToJson(ToUploadVideoModel data) => json.encode(data.toJson());

class ToUploadVideoModel {
  ToUploadVideoModel({
    required this.studentId,
    required this.teacherId,
    required this.classId,
    required this.subjectId,
    required this.link,
    required this.description
  });
  var studentId;
  int classId;
  int subjectId;
  int teacherId;
  String link;
  String description;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "teacher_id": teacherId,
    "class_id": classId,
    "subject_id": subjectId,
    "link": link,
    "description": description,
  };
}

class UploadVideoModel {
  UploadVideoModel({
    required this.error,
    required this.status,
  });

  int error;
  String status;

  factory UploadVideoModel.fromJson(Map<String, dynamic> json) => UploadVideoModel(
    error: json["error"],
    status: json["status"],
  );
}
