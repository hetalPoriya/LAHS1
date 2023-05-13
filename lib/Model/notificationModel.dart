// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(ToNotificationModel data) => json.encode(data.toJson());

class ToNotificationModel {
  ToNotificationModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class NotificationModel {
  NotificationModel({
    required this.error,
    required this.status,
    required this.notifications,
    required this.unviewedNotifications,
  });

  int error;
  String status;
  List<Notification> notifications;
  int unviewedNotifications;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    error: json["error"],
    status: json["status"],
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
    unviewedNotifications: json["unviewed_notifications"],
  );
}

class Notification {
  Notification({
    required this.viewed,
    required this.title,
    required this.message,
    required this.createdAt,
  });

  int viewed;
  String title;
  String message;
  DateTime createdAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    viewed: json["viewed"],
    title: json["title"],
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
  );

}
