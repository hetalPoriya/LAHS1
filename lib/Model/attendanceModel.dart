// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(ToAttendanceModel data) => json.encode(data.toJson());

class ToAttendanceModel {
  ToAttendanceModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class AttendanceModel {
  AttendanceModel({
    required this.error,
    required this.status,
    required this.attendance,
  });

  int error;
  String status;
  List<Attendance> attendance;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    error: json["error"],
    status: json["status"],
    attendance: List<Attendance>.from(json["attendance"].map((x) => Attendance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
  };
}

class Attendance {
  Attendance({
    required this.id,
    required this.classId,
    required this.sectionId,
    required this.studentId,
    required this.teacherId,
    required this.status,
    required this.attendanceDate,
  });

  int id;
  int classId;
  int sectionId;
  int studentId;
  int teacherId;
  String status;
  DateTime attendanceDate;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["id"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    studentId: json["student_id"],
    teacherId: json["teacher_id"],
    status: json["status"],
    attendanceDate: DateTime.parse(json["attendance_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_id": classId,
    "section_id": sectionId,
    "student_id": studentId,
    "teacher_id": teacherId,
    "status": status,
    "attendance_date": "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
  };
}
