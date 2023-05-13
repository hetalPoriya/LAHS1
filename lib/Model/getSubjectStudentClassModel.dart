// To parse this JSON data, do
//
//     final getSubjectStudentClassModel = getSubjectStudentClassModelFromJson(jsonString);

import 'dart:convert';

GetSubjectStudentClassModel getSubjectStudentClassModelFromJson(String str) => GetSubjectStudentClassModel.fromJson(json.decode(str));

String getSubjectStudentClassModelToJson(ToGetSubjectStudentClassModel data) => json.encode(data.toJson());

class ToGetSubjectStudentClassModel {
  ToGetSubjectStudentClassModel({
    required this.class_id,
  });
  int class_id;
  Map<String, dynamic> toJson() => {
    "class_id": class_id,
  };
}

class GetSubjectStudentClassModel {
  GetSubjectStudentClassModel({
    required this.error,
    required this.status,
    required this.subjects,
    required this.students,
  });

  int error;
  String status;
  List<Subject> subjects;
  List<Student> students;

  factory GetSubjectStudentClassModel.fromJson(Map<String, dynamic> json) => GetSubjectStudentClassModel(
    error: json["error"],
    status: json["status"],
    subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
    students: List<Student>.from(json["students"].map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
    "students": List<dynamic>.from(students.map((x) => x.toJson())),
  };
}

class Student {
  Student({
    required this.studentId,
    required this.studentName,
  });

  int studentId;
  String studentName;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    studentId: json["student_id"],
    studentName: json["student_name"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "student_name": studentName,
  };
}

class Subject {
  Subject({
    required this.subjectId,
    required this.subjectName,
  });

  int subjectId;
  String subjectName;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    subjectId: json["subject_id"],
    subjectName: json["subject_name"],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "subject_name": subjectName,
  };
}
