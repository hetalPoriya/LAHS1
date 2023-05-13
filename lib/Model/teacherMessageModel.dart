// To parse this JSON data, do
//
//     final teacherMessageModel = teacherMessageModelFromJson(jsonString);

import 'dart:convert';

TeacherMessageModel teacherMessageModelFromJson(String str) => TeacherMessageModel.fromJson(json.decode(str));

String teacherMessageModelToJson(ToTeacherMessageModel data) => json.encode(data.toJson());

class ToTeacherMessageModel {
  ToTeacherMessageModel({
    required this.teacherId,
  });
  int teacherId;
  Map<String, dynamic> toJson() => {
    "teacher_id": teacherId,
  };
}

class TeacherMessageModel {
  TeacherMessageModel({
    required this.error,
    required this.status,
    required this.outboxMessages,
    required this.inboxMessages,
  });

  int error;
  String status;
  List<BoxMessage> outboxMessages;
  List<BoxMessage> inboxMessages;

  factory TeacherMessageModel.fromJson(Map<String, dynamic> json) => TeacherMessageModel(
    error: json["error"],
    status: json["status"],
    outboxMessages: List<BoxMessage>.from(json["outbox_messages"].map((x) => BoxMessage.fromJson(x))),
    inboxMessages: List<BoxMessage>.from(json["inbox_messages"].map((x) => BoxMessage.fromJson(x))),
  );
}

class BoxMessage {
  BoxMessage({
    required this.messageId,
    required this.studentName,
    required this.studentId,
    required this.messageTitle,
    required this.message,
    required this.messageReceivedOn,
    required this.messageSentOn,
  });

  int messageId;
  String studentName;
  int studentId;
  String messageTitle;
  String message;
  DateTime? messageReceivedOn;
  DateTime? messageSentOn;

  factory BoxMessage.fromJson(Map<String, dynamic> json) => BoxMessage(
    messageId: json["message_id"],
    studentName: json["student_name"],
    studentId: json["student_id"],
    messageTitle: json["message_title"],
    message: json["message"],
    messageReceivedOn: json["message_received_on"] == null ? null : DateTime.parse(json["message_received_on"]),
    messageSentOn: json["message_sent_on"] == null ? null : DateTime.parse(json["message_sent_on"]),
  );
}
