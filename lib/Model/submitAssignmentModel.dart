// To parse this JSON data, do
//
//     final stuCompMsgModel = stuCompMsgModelFromJson(jsonString);

import 'dart:convert';

SubmitAssignmentModel submitAssignmentModelFromJson(String str) => SubmitAssignmentModel.fromJson(json.decode(str));

String submitAssignmentModelToJson(TosubmitAssignmentModel data) => json.encode(data.toJson());

class TosubmitAssignmentModel {
  TosubmitAssignmentModel({
    required this.studentId,
    required this.assignmentId,
    required this.assignDoc,
    required this.description,
  });
  int studentId;
  int assignmentId;
  List assignDoc;
  String description;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "assignment_id": assignmentId,
    "assign_docs[]": assignDoc,
    "description": description,
  };
}

class SubmitAssignmentModel {
  SubmitAssignmentModel({
    required this.error,
    required this.status,
  });

  int error;
  String status;

  factory SubmitAssignmentModel.fromJson(Map<String, dynamic> json) => SubmitAssignmentModel(
    error: json["error"],
    status: json["status"],
  );
}
