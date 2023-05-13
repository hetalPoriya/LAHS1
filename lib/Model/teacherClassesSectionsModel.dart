import 'dart:convert';

TeacherClassesSectionsModel teacherClassesSectionsModelFromJson(String str) => TeacherClassesSectionsModel.fromJson(json.decode(str));

String teacherClassesSectionsModelToJson(ToTeacherClassesSectionsModel data) => json.encode(data.toJson());

class ToTeacherClassesSectionsModel {
  ToTeacherClassesSectionsModel({
    required this.teacher_id,
  });
  int teacher_id;
  Map<String, dynamic> toJson() => {
    "teacher_id": teacher_id,
  };
}

class TeacherClassesSectionsModel {
  TeacherClassesSectionsModel({
    required this.error,
    required this.status,
    required this.classesSections,
  });

  int error;
  String status;
  List<ClassesSection> classesSections;

  factory TeacherClassesSectionsModel.fromJson(Map<String, dynamic> json) => TeacherClassesSectionsModel(
    error: json["error"],
    status: json["status"],
    classesSections: List<ClassesSection>.from(json["classes_sections"].map((x) => ClassesSection.fromJson(x))),
  );
}

class ClassesSection {
  ClassesSection({
    required this.classId,
    required this.className,
    required this.sectionId,
    required this.sectionName,
  });

  int classId;
  String className;
  int sectionId;
  String sectionName;

  factory ClassesSection.fromJson(Map<String, dynamic> json) => ClassesSection(
    classId: json["class_id"],
    className: json["class_name"],
    sectionId: json["section_id"],
    sectionName: json["section_name"],
  );

}
