// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(ToMessageModel data) => json.encode(data.toJson());

class ToMessageModel {
  ToMessageModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class MessageModel {
  MessageModel({
    required this.error,
    required this.status,
    required this.outboxMessages,
    required this.inboxMessages,
  });

  int error;
  String status;
  List<BoxMessage> outboxMessages;
  List<BoxMessage> inboxMessages;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    error: json["error"],
    status: json["status"],
    outboxMessages: List<BoxMessage>.from(json["outbox_messages"].map((x) => BoxMessage.fromJson(x))),
    inboxMessages: List<BoxMessage>.from(json["inbox_messages"].map((x) => BoxMessage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "outbox_messages": List<dynamic>.from(outboxMessages.map((x) => x.toJson())),
    "inbox_messages": List<dynamic>.from(inboxMessages.map((x) => x.toJson())),
  };
}

class BoxMessage {
  BoxMessage({
    required this.messageId,
    required this.teacherName,
    required this.teacherId,
    required this.messageTitle,
    required this.message,
    required this.messageReceivedOn,
    required this.messageSentOn,
  });

  int messageId;
  String teacherName;
  int teacherId;
  String messageTitle;
  String message;
  DateTime? messageReceivedOn;
  DateTime? messageSentOn;

  factory BoxMessage.fromJson(Map<String, dynamic> json) => BoxMessage(
    messageId: json["message_id"],
    teacherName: json["teacher_name"],
    teacherId: json["teacher_id"],
    messageTitle: json["message_title"],
    message: json["message"],
    messageReceivedOn: json["message_received_on"] == null ? null : DateTime.parse(json["message_received_on"]),
    messageSentOn: json["message_sent_on"] == null ? null : DateTime.parse(json["message_sent_on"]),
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "teacher_name": teacherName,
    "teacher_id": teacherId,
    "message_title": messageTitle,
    "message": message,
    "message_received_on": messageReceivedOn == null ? null : messageReceivedOn!.toIso8601String(),
    "message_sent_on": messageSentOn == null ? null : messageSentOn!.toIso8601String(),
  };
}
