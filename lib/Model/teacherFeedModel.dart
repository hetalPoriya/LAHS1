// To parse this JSON data, do
//
//     final teacherFeedModel = teacherFeedModelFromJson(jsonString);

import 'dart:convert';

TeacherFeedModel teacherFeedModelFromJson(String str) => TeacherFeedModel.fromJson(json.decode(str));
String teacherFeedModelToJson(ToTeacherFeedModel data) => json.encode(data.toJson());

class ToTeacherFeedModel {
  ToTeacherFeedModel({
    required this.teacherId,
  });
  int teacherId;
  Map<String, dynamic> toJson() => {
    "teacher_id": teacherId,
  };
}

class TeacherFeedModel {
  TeacherFeedModel({
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

  factory TeacherFeedModel.fromJson(Map<String, dynamic> json) => TeacherFeedModel(
    error: json["error"],
    status: json["status"],
    notifications: List<Event>.from(json["notifications"].map((x) => Event.fromJson(x))),
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    others: List<Event>.from(json["others"].map((x) => Event.fromJson(x))),
  );
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
  dynamic timingFrom;
  dynamic timingTo;
  DateTime createdAt;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    postType: json["post_type"],
    title: json["title"],
    message: json["message"],
    timingFrom: json["timing_from"],
    timingTo: json["timing_to"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

