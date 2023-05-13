// To parse this JSON data, do
//
//     final assessmentCertModel = assessmentCertModelFromJson(jsonString);

import 'dart:convert';

AssessmentCertModel assessmentCertModelFromJson(String str) => AssessmentCertModel.fromJson(json.decode(str));

String assessmentCertModelToJson(ToAssessmentCertModel data) => json.encode(data.toJson());

class ToAssessmentCertModel {
  ToAssessmentCertModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class AssessmentCertModel {
  AssessmentCertModel({
    required this.error,
    required this.status,
    required this.certificates,
  });

  int error;
  String status;
  List<Certificate> certificates;

  factory AssessmentCertModel.fromJson(Map<String, dynamic> json) => AssessmentCertModel(
    error: json["error"],
    status: json["status"],
    certificates: List<Certificate>.from(json["certificates"].map((x) => Certificate.fromJson(x))),
  );
}

class Certificate {
  Certificate({
    required this.certificateId,
    required this.certificateFile,
    required this.comment,
    required this.uploadedAt,
    required this.uploadedBy,
  });

  int certificateId;
  String certificateFile;
  String comment;
  DateTime uploadedAt;
  String uploadedBy;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    certificateId: json["certificate_id"],
    certificateFile: json["certificate_file"],
    comment: json["comment"] == null ? null : json["comment"],
    uploadedAt: DateTime.parse(json["uploaded_at"]),
    uploadedBy: json["uploaded_by"],
  );
}
