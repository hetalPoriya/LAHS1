// To parse this JSON data, do
//
//     final getTeacherClassesModel = getTeacherClassesModelFromJson(jsonString);

import 'dart:convert';

GetTeacherClassesModel getTeacherClassesModelFromJson(String str) => GetTeacherClassesModel.fromJson(json.decode(str));

String getTeacherClassesModelToJson(ToGetTeacherClassesModel data) => json.encode(data.toJson());

class ToGetTeacherClassesModel {
  ToGetTeacherClassesModel({
    required this.teacher_id,
  });
  int teacher_id;
  Map<String, dynamic> toJson() => {
    "teacher_id": teacher_id,
  };
}

class GetTeacherClassesModel {
  GetTeacherClassesModel({
    required this.error,
    required this.status,
    required this.classes,
  });

  int error;
  String status;
  List<Class> classes;

  factory GetTeacherClassesModel.fromJson(Map<String, dynamic> json) => GetTeacherClassesModel(
    error: json["error"],
    status: json["status"],
    classes: List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
  };
}

class Class {
  Class({
    required this.className,
    required this.classId,
  });

  String className;
  int classId;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    className: json["class_name"],
    classId: json["class_id"],
  );

  Map<String, dynamic> toJson() => {
    "class_name": className,
    "class_id": classId,
  };
}
