// To parse this JSON data, do
//
//     final reportCardModel = reportCardModelFromJson(jsonString);

import 'dart:convert';

ReportCardModel reportCardModelFromJson(String str) => ReportCardModel.fromJson(json.decode(str));

String reportCardModelToJson(ToReportCardModel data) => json.encode(data.toJson());

class ToReportCardModel {
  ToReportCardModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class ReportCardModel {
  ReportCardModel({
    required this.error,
    required this.status,
    required this.reportCards,
  });

  int error;
  String status;
  List<ReportCard> reportCards;

  factory ReportCardModel.fromJson(Map<String, dynamic> json) => ReportCardModel(
    error: json["error"],
    status: json["status"],
    reportCards: List<ReportCard>.from(json["report_cards"].map((x) => ReportCard.fromJson(x))),
  );
}

class ReportCard {
  ReportCard({
    required this.reportCardId,
    required this.reportCardFile,
    required this.remarks,
    required this.uploadedAt,
    required this.uploadedBy,
  });

  int reportCardId;
  String reportCardFile;
  String remarks;
  DateTime uploadedAt;
  String uploadedBy;

  factory ReportCard.fromJson(Map<String, dynamic> json) => ReportCard(
    reportCardId: json["report_card_id"],
    reportCardFile: json["report_card_file"],
    remarks: json["remarks"] == null ? null : json["remarks"],
    uploadedAt: DateTime.parse(json["uploaded_at"]),
    uploadedBy: json["uploaded_by"],
  );
}
