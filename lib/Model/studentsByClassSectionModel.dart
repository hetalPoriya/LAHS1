// To parse this JSON data, do
//
//     final studentsByClassSectionModel = studentsByClassSectionModelFromJson(jsonString);

import 'dart:convert';

StudentsByClassSectionModel studentsByClassSectionModelFromJson(String str) => StudentsByClassSectionModel.fromJson(json.decode(str));

String studentsByClassSectionModelToJson(ToStudentsByClassSectionModel data) => json.encode(data.toJson());

class ToStudentsByClassSectionModel {
  ToStudentsByClassSectionModel({
    required this.class_id,
    required this.section_id
  });
  int class_id;
  int section_id;
  Map<String, dynamic> toJson() => {
    "class_id": class_id,
    "section_id": section_id,
  };
}

class StudentsByClassSectionModel {
  StudentsByClassSectionModel({
    required this.error,
    required this.status,
    required this.students,
  });

  int error;
  String status;
  List<Student> students;

  factory StudentsByClassSectionModel.fromJson(Map<String, dynamic> json) => StudentsByClassSectionModel(
    error: json["error"],
    status: json["status"],
    students: List<Student>.from(json["students"].map((x) => Student.fromJson(x))),
  );
}

class Student {
  Student({
    required this.studentName,
    required this.studentId,
  });

  String studentName;
  int studentId;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    studentName: json["student_name"],
    studentId: json["student_id"],
  );
}
