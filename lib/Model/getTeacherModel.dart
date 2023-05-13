import 'dart:convert';

GetTeacherModel getTeacherModelFromJson(String str) => GetTeacherModel.fromJson(json.decode(str));

String getTeacherModelToJson(ToGetTeacherModel data) => json.encode(data.toJson());

class ToGetTeacherModel {
  ToGetTeacherModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class GetTeacherModel {
  GetTeacherModel({
    required this.error,
    required this.status,
    required this.teachers,
  });

  int error;
  String status;
  List<Teacher> teachers;

  factory GetTeacherModel.fromJson(Map<String, dynamic> json) => GetTeacherModel(
    error: json["error"],
    status: json["status"],
    teachers: List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "teachers": List<dynamic>.from(teachers.map((x) => x.toJson())),
  };
}

class Teacher {
  Teacher({
    required this.teacherName,
    required this.teacherId,
    required this.teacherType,
  });

  String teacherName;
  int teacherId;
  String teacherType;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    teacherName: json["teacher_name"],
    teacherId: json["teacher_id"],
    teacherType: json["teacher_type"],
  );

  Map<String, dynamic> toJson() => {
    "teacher_name": teacherName,
    "teacher_id": teacherId,
    "teacher_type": teacherType,
  };
}
