// To parse this JSON data, do
//
//     final teacherViewAttendanceModel = teacherViewAttendanceModelFromJson(jsonString);

import 'dart:convert';

TeacherViewAttendanceModel teacherViewAttendanceModelFromJson(String str) => TeacherViewAttendanceModel.fromJson(json.decode(str));

String teacherViewAttendanceModelToJson(ToTeacherViewAttendanceModel data) => json.encode(data.toJson());

class ToTeacherViewAttendanceModel {
  ToTeacherViewAttendanceModel({
    required this.classId,
    required this.sectionId,
    required this.attendanceDate,
  });
  int classId;
  int sectionId;
  String attendanceDate;
  Map<String, dynamic> toJson() => {
    "class_id": classId,
    "section_id": sectionId,
    "attendance_date": attendanceDate,
  };
}

class TeacherViewAttendanceModel {
  TeacherViewAttendanceModel({
    required this.error,
    required this.status,
    required this.attendance,
  });

  int error;
  String status;
  List<Attendance> attendance;

  factory TeacherViewAttendanceModel.fromJson(Map<String, dynamic> json) => TeacherViewAttendanceModel(
    error: json["error"],
    status: json["status"],
    attendance: List<Attendance>.from(json["attendance"].map((x) => Attendance.fromJson(x))),
  );
}

class Attendance {
  Attendance({
    required this.studentName,
    required this.status,
    required this.admissionId,
  });

  String studentName;
  String status;
  String admissionId;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    studentName: json["student_name"],
    status: json["status"],
    admissionId: json["admission_id"],
  );

}
