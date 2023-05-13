// To parse this JSON data, do
//
//     final teacherAssignmentModel = teacherAssignmentModelFromJson(jsonString);

import 'dart:convert';

TeacherAssignmentModel teacherAssignmentModelFromJson(String str) => TeacherAssignmentModel.fromJson(json.decode(str));

String teacherAssignmentModelToJson(ToTeacherAssignmentModel data) => json.encode(data.toJson());

class ToTeacherAssignmentModel {
  ToTeacherAssignmentModel({
    required this.teacherId,
  });
  int teacherId;
  Map<String, dynamic> toJson() => {
    "teacher_id": teacherId,
  };
}

class TeacherAssignmentModel {
  TeacherAssignmentModel({
    required this.error,
    required this.status,
    required this.checkedAssignments,
    required this.uncheckedAssignments,
    required this.allUploadedAssignments,
  });

  int error;
  String status;
  List<CheckedAssignment> checkedAssignments;
  List<CheckedAssignment> uncheckedAssignments;
  List<AllUploadedAssignment> allUploadedAssignments;

  factory TeacherAssignmentModel.fromJson(Map<String, dynamic> json) => TeacherAssignmentModel(
    error: json["error"],
    status: json["status"],
    checkedAssignments: List<CheckedAssignment>.from(json["checked_assignments"].map((x) => CheckedAssignment.fromJson(x))),
    uncheckedAssignments: List<CheckedAssignment>.from(json["unchecked_assignments"].map((x) => CheckedAssignment.fromJson(x))),
    allUploadedAssignments: List<AllUploadedAssignment>.from(json["all_uploaded_assignments"].map((x) => AllUploadedAssignment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "checked_assignments": List<dynamic>.from(checkedAssignments.map((x) => x.toJson())),
    "unchecked_assignments": List<dynamic>.from(uncheckedAssignments.map((x) => x.toJson())),
    "all_uploaded_assignments": List<dynamic>.from(allUploadedAssignments.map((x) => x.toJson())),
  };
}

class AllUploadedAssignment {
  AllUploadedAssignment({
    required this.assignmentTitle,
    required this.assignmentDescription,
    required this.assignmentImage,
    required this.assignmentLink,
    required this.assignmentExpiryDate,
    required this.assignmentActiveStatus,
    required this.className,
    required this.sectionName,
    required this.subjectName,
  });

  String assignmentTitle;
  String assignmentDescription;
  String assignmentImage;
  String assignmentLink;
  DateTime assignmentExpiryDate;
  String assignmentActiveStatus;
  String className;
  String sectionName;
  String subjectName;

  factory AllUploadedAssignment.fromJson(Map<String, dynamic> json) => AllUploadedAssignment(
    assignmentTitle: json["assignment_title"],
    assignmentDescription: json["assignment_description"],
    assignmentImage: json["assignment_image"],
    assignmentLink: json["assignment_link"] == null ? null : json["assignment_link"],
    assignmentExpiryDate: DateTime.parse(json["assignment_expiry_date"]),
    assignmentActiveStatus: json["assignment_active_status"],
    className: json["class_name"],
    sectionName: json["section_name"],
    subjectName: json["subject_name"],
  );

  Map<String, dynamic> toJson() => {
    "assignment_title": assignmentTitle,
    "assignment_description": assignmentDescription,
    "assignment_image": assignmentImage,
    "assignment_link": assignmentLink == null ? null : assignmentLink,
    "assignment_expiry_date": assignmentExpiryDate.toIso8601String(),
    "assignment_active_status": assignmentActiveStatus,
    "class_name": className,
    "section_name": sectionName,
    "subject_name": subjectName,
  };
}

class CheckedAssignment {
  CheckedAssignment({
    required this.assignmentTitle,
    required this.assignmentDescription,
    required this.assignmentImage,
    required this.assignmentLink,
    required this.assignmentExpiryDate,
    required this.assignmentActiveStatus,
    required this.assignmentSubmitDateTime,
    required this.assignmentMark,
    required this.rejectStatus,
    required this.assignmentFeedback,
    required this.assignmentDocs,
    required this.remark,
    required this.studentName,
    required this.className,
    required this.sectionName,
    required this.subjectName,
  });

  String assignmentTitle;
  String assignmentDescription;
  String assignmentImage;
  String assignmentLink;
  DateTime assignmentExpiryDate;
  String assignmentActiveStatus;
  DateTime assignmentSubmitDateTime;
  String assignmentMark;
  int rejectStatus;
  String assignmentFeedback;
  String assignmentDocs;
  String remark;
  String studentName;
  String className;
  String sectionName;
  String subjectName;

  factory CheckedAssignment.fromJson(Map<String, dynamic> json) => CheckedAssignment(
    assignmentTitle: json["assignment_title"],
    assignmentDescription: json["assignment_description"],
    assignmentImage: json["assignment_image"],
    assignmentLink: json["assignment_link"] == null ? null : json["assignment_link"],
    assignmentExpiryDate: DateTime.parse(json["assignment_expiry_date"]),
    assignmentActiveStatus: json["assignment_active_status"],
    assignmentSubmitDateTime: DateTime.parse(json["assignment_submit_date_time"]),
    assignmentMark: json["assignment_mark"] == null ? null : json["assignment_mark"],
    rejectStatus: json["reject_status"],
    assignmentFeedback: json["assignment_feedback"] == null ? null : json["assignment_feedback"],
    assignmentDocs: json["assignment_docs"],
    remark: json["remark"] == null ? null : json["remark"],
    studentName: json["student_name"],
    className: json["class_name"],
    sectionName: json["section_name"],
    subjectName: json["subject_name"],
  );

  Map<String, dynamic> toJson() => {
    "assignment_title": assignmentTitle,
    "assignment_description": assignmentDescription,
    "assignment_image": assignmentImage,
    "assignment_link": assignmentLink == null ? null : assignmentLink,
    "assignment_expiry_date": assignmentExpiryDate.toIso8601String(),
    "assignment_active_status": assignmentActiveStatus,
    "assignment_submit_date_time": assignmentSubmitDateTime.toIso8601String(),
    "assignment_mark": assignmentMark == null ? null : assignmentMark,
    "reject_status": rejectStatus,
    "assignment_feedback": assignmentFeedback == null ? null : assignmentFeedback,
    "assignment_docs": assignmentDocs,
    "remark": remark == null ? null : remark,
    "student_name": studentName,
    "class_name": className,
    "section_name": sectionName,
    "subject_name": subjectName,
  };
}
