// To parse this JSON data, do
//
//     final assignmentModel = assignmentModelFromJson(jsonString);

import 'dart:convert';

AssignmentModel assignmentModelFromJson(String str) => AssignmentModel.fromJson(json.decode(str));

String assignmentModelToJson(ToAssignmentModel data) => json.encode(data.toJson());

class ToAssignmentModel {
  ToAssignmentModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class AssignmentModel {
  AssignmentModel({
    required this.error,
    required this.status,
    required this.pastAssignments,
    required this.submittedAssignments,
    required this.pendingAssignments,
  });

  int error;
  String status;
  List<Assignment> pastAssignments;
  List<SubmittedAssignment> submittedAssignments;
  List<Assignment> pendingAssignments;

  factory AssignmentModel.fromJson(Map<String, dynamic> json) => AssignmentModel(
    error: json["error"],
    status: json["status"],
    pastAssignments: List<Assignment>.from(json["past_assignments"].map((x) => Assignment.fromJson(x))),
    submittedAssignments: List<SubmittedAssignment>.from(json["submitted_assignments"].map((x) => SubmittedAssignment.fromJson(x))),
    pendingAssignments: List<Assignment>.from(json["pending_assignments"].map((x) => Assignment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "past_assignments": List<dynamic>.from(pastAssignments.map((x) => x.toJson())),
    "submitted_assignments": List<dynamic>.from(submittedAssignments.map((x) => x.toJson())),
    "pending_assignments": List<dynamic>.from(pendingAssignments.map((x) => x.toJson())),
  };
}

class Assignment {
  Assignment({
    required this.id,
    required this.teacherId,
    required this.classId,
    required this.sectionId,
    required this.branchId,
    required this.subject,
    required this.title,
    required this.description,
    required this.image,
    required this.video,
    required this.link,
    required this.scheduleDate,
    required this.createdAt,
    required this.expireAt,
    required this.active,
    required this.className,
    required this.subjectName,
    required this.sectionName,
  });

  int id;
  int teacherId;
  int classId;
  int sectionId;
  String branchId;
  String subject;
  String title;
  String description;
  String image;
  String video;
  String link;
  DateTime scheduleDate;
  DateTime createdAt;
  DateTime expireAt;
  String active;
  String className;
  String subjectName;
  String sectionName;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    id: json["id"],
    teacherId: json["teacher_id"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    branchId: json["branch_id"],
    subject: json["subject"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    video: json["video"],
    link: json["link"] == null ? null : json["link"],
    scheduleDate: DateTime.parse(json["schedule_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    expireAt: DateTime.parse(json["expire_at"]),
    active: json["active"],
    className: json["class_name"],
    subjectName: json["subject_name"],
    sectionName: json["section_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "teacher_id": teacherId,
    "class_id": classId,
    "section_id": sectionId,
    "branch_id": branchId,
    "subject": subject,
    "title": title,
    "description": description,
    "image": image,
    "video": video,
    "link": link == null ? null : link,
    "schedule_date": scheduleDate.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "expire_at": expireAt.toIso8601String(),
    "active": active,
    "class_name": className,
    "subject_name": subjectName,
    "section_name": sectionName,
  };
}

class SubmittedAssignment {
  SubmittedAssignment({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.submitStatus,
    required this.submitDateTime,
    required this.teacherCheckStatus,
    required this.assignmentMark,
    required this.rejectStatus,
    required this.feedback,
    required this.assignmentDocs,
    required this.assignmentDescription,
    required this.remark,
    required this.updatedAt,
    required this.submissionId,
    required this.teacherId,
    required this.classId,
    required this.sectionId,
    required this.branchId,
    required this.subject,
    required this.title,
    required this.description,
    required this.image,
    required this.video,
    required this.link,
    required this.scheduleDate,
    required this.createdAt,
    required this.expireAt,
    required this.active,
    required this.className,
    required this.sectionName,
    required this.subjectName,
  });

  int id;
  int assignmentId;
  int studentId;
  int submitStatus;
  DateTime submitDateTime;
  int teacherCheckStatus;
  String assignmentMark;
  int rejectStatus;
  String feedback;
  String assignmentDocs;
  String assignmentDescription;
  String remark;
  DateTime updatedAt;
  int submissionId;
  int teacherId;
  int classId;
  int sectionId;
  String branchId;
  String subject;
  String title;
  String description;
  String image;
  String video;
  dynamic link;
  DateTime scheduleDate;
  DateTime createdAt;
  DateTime expireAt;
  String active;
  String className;
  String sectionName;
  String subjectName;

  factory SubmittedAssignment.fromJson(Map<String, dynamic> json) => SubmittedAssignment(
    id: json["id"],
    assignmentId: json["assignment_id"],
    studentId: json["student_id"],
    submitStatus: json["submit_status"],
    submitDateTime: DateTime.parse(json["submit_date_time"]),
    teacherCheckStatus: json["teacher_check_status"],
    assignmentMark: json["assignment_mark"],
    rejectStatus: json["reject_status"],
    feedback: json["feedback"],
    assignmentDocs: json["assignment_docs"],
    assignmentDescription: json["assignment_description"],
    remark: json["remark"],
    updatedAt: DateTime.parse(json["updated_at"]),
    submissionId: json["submission_id"],
    teacherId: json["teacher_id"],
    classId: json["class_id"],
    sectionId: json["section_id"],
    branchId: json["branch_id"],
    subject: json["subject"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    video: json["video"],
    link: json["link"],
    scheduleDate: DateTime.parse(json["schedule_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    expireAt: DateTime.parse(json["expire_at"]),
    active: json["active"],
    className: json["class_name"],
    sectionName: json["section_name"],
    subjectName: json["subject_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "assignment_id": assignmentId,
    "student_id": studentId,
    "submit_status": submitStatus,
    "submit_date_time": submitDateTime.toIso8601String(),
    "teacher_check_status": teacherCheckStatus,
    "assignment_mark": assignmentMark,
    "reject_status": rejectStatus,
    "feedback": feedback,
    "assignment_docs": assignmentDocs,
    "assignment_description": assignmentDescription,
    "remark": remark,
    "updated_at": updatedAt.toIso8601String(),
    "submission_id": submissionId,
    "teacher_id": teacherId,
    "class_id": classId,
    "section_id": sectionId,
    "branch_id": branchId,
    "subject": subject,
    "title": title,
    "description": description,
    "image": image,
    "video": video,
    "link": link,
    "schedule_date": scheduleDate.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "expire_at": expireAt.toIso8601String(),
    "active": active,
    "class_name": className,
    "section_name": sectionName,
    "subject_name": subjectName,
  };
}
