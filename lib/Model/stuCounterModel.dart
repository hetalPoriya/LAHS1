// To parse this JSON data, do
//
//     final stuCounterModel = stuCounterModelFromJson(jsonString);

import 'dart:convert';

StuCounterModel stuCounterModelFromJson(String str) => StuCounterModel.fromJson(json.decode(str));

String stuCounterModelToJson(ToStuCounterModel data) => json.encode(data.toJson());

class ToStuCounterModel {
  ToStuCounterModel({
    required this.student_id
  });
  int student_id;
  Map<String, dynamic> toJson() => {
    "student_id": student_id,
  };
}

class StuCounterModel {
  StuCounterModel({
    required this.error,
    required this.assignmentCount,
    required this.messageCount,
    required this.eventCount,
    required this.certificateCount,
    required this.otherCount,
    required this.message,
    required this.notification,
  });

  bool error;
  int assignmentCount;
  int messageCount;
  int eventCount;
  int certificateCount;
  int otherCount;
  String message;
  int notification;

  factory StuCounterModel.fromJson(Map<String, dynamic> json) => StuCounterModel(
    error: json["error"],
    assignmentCount: json["assignment_count"],
    messageCount: json["message_count"],
    eventCount: json["event_count"],
    certificateCount: json["certificate_count"],
    otherCount: json["other_count"],
    message: json["message"],
    notification: json["notification"],
  );
}
