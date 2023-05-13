// To parse this JSON data, do
//
//     final teacherVideoModel = teacherVideoModelFromJson(jsonString);

import 'dart:convert';

TeacherVideoModel teacherVideoModelFromJson(String str) => TeacherVideoModel.fromJson(json.decode(str));

String teacherVideoModelToJson(ToTeacherVideoModel data) => json.encode(data.toJson());

class ToTeacherVideoModel {
  ToTeacherVideoModel({
    required this.teacherId,
  });
  int teacherId;
  Map<String, dynamic> toJson() => {
    "teacher_id": teacherId,
  };
}

class TeacherVideoModel {
  TeacherVideoModel({
    required this.error,
    required this.status,
    required this.videos,
  });

  int error;
  String status;
  Map<String, dynamic> videos;

  factory TeacherVideoModel.fromJson(Map<String, dynamic> json) => TeacherVideoModel(
    error: json["error"],
    status: json["status"],
    videos: json["videos"],
  );
}

class Videos {
  Videos({
    required this.php,
    required this.python,
  });

  List<Php> php;
  List<Php> python;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
    php: List<Php>.from(json["PHP"].map((x) => Php.fromJson(x))),
    python: List<Php>.from(json["Python"].map((x) => Php.fromJson(x))),
  );
}

class Php {
  Php({
    required this.videoLink,
    required this.videoDescription,
    required this.studentId,
    required this.className,
    required this.classId,
    required this.subjectId,
    required this.student,
  });

  String videoLink;
  String videoDescription;
  String studentId;
  String className;
  int classId;
  int subjectId;
  List<Student> student;

  factory Php.fromJson(Map<String, dynamic> json) => Php(
    videoLink: json["video_link"],
    videoDescription: json["video_description"],
    studentId: json["student_id"],
    className: json["class_name"],
    classId: json["class_id"],
    subjectId: json["subject_id"],
    student: List<Student>.from(json["student"].map((x) => Student.fromJson(x))),
  );
}

class Student {
  Student({
    required this.studentName,
    required this.studentEmail,
    required this.admissionId,
  });

  String studentName;
  String studentEmail;
  String admissionId;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    studentName: json["student_name"],
    studentEmail: json["student_email"],
    admissionId: json["admission_id"],
  );
}
