// To parse this JSON data, do
//
//     final markAttendanceModel = markAttendanceModelFromJson(jsonString);

import 'dart:convert';

MarkAttendanceModel markAttendanceModelFromJson(String str) => MarkAttendanceModel.fromJson(json.decode(str));

String markAttendanceModelToJson(ToMarkAttendanceModel data) => json.encode(data.toJson());

class ToMarkAttendanceModel {
  ToMarkAttendanceModel({
    required this.studentId,
    required this.teacherId,
    required this.classId,
    required this.sectionId,
    required this.attendanceDate,
  });
  var studentId;
  int teacherId;
  int classId;
  int sectionId;
  String attendanceDate;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "teacher_id": teacherId,
    "class_id": classId,
    "section_id": sectionId,
    "attendance_date": attendanceDate,
  };
}

class MarkAttendanceModel {
  MarkAttendanceModel({
    required this.error,
    required this.status,
  });

  int error;
  String status;

  factory MarkAttendanceModel.fromJson(Map<String, dynamic> json) => MarkAttendanceModel(
    error: json["error"],
    status: json["status"],
  );
}
