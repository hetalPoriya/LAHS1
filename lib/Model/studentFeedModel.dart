// To parse this JSON data, do
//
//     final studentFeedModel = studentFeedModelFromJson(jsonString);

import 'dart:convert';

StudentFeedModel studentFeedModelFromJson(String str) => StudentFeedModel.fromJson(json.decode(str));

String studentFeedModelToJson(ToStudentFeedModel data) => json.encode(data.toJson());

class ToStudentFeedModel {
  ToStudentFeedModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class StudentFeedModel {
  StudentFeedModel({
    required this.error,
    required this.status,
    required this.notifications,
    required this.events,
    required this.others,
  });

  int error;
  String status;
  List<Event> notifications;
  List<Event> events;
  List<Event> others;

  factory StudentFeedModel.fromJson(Map<String, dynamic> json) => StudentFeedModel(
    error: json["error"],
    status: json["status"],
    notifications: List<Event>.from(json["notifications"].map((x) => Event.fromJson(x))),
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    others: List<Event>.from(json["others"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
    "others": List<dynamic>.from(others.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    required this.postType,
    required this.title,
    required this.message,
    required this.timingFrom,
    required this.timingTo,
    required this.createdAt,
  });

  int postType;
  String title;
  String message;
  DateTime? timingFrom;
  DateTime? timingTo;
  DateTime createdAt;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    postType: json["post_type"],
    title: json["title"],
    message: json["message"],
    timingFrom: json["timing_from"] == null ? null : DateTime.parse(json["timing_from"]),
    timingTo: json["timing_to"] == null ? null : DateTime.parse(json["timing_to"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "post_type": postType,
    "title": title,
    "message": message,
    "timing_from": timingFrom == null ? null : timingFrom!.toIso8601String(),
    "timing_to": timingTo == null ? null : timingTo!.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}
