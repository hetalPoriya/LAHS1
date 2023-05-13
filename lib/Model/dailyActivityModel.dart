// To parse this JSON data, do
//
//     final dailyActivityModel = dailyActivityModelFromJson(jsonString);

import 'dart:convert';

DailyActivityModel dailyActivityModelFromJson(String str) => DailyActivityModel.fromJson(json.decode(str));

String dailyActivityModelToJson(ToDailyActivityModel data) => json.encode(data.toJson());

class ToDailyActivityModel {
  ToDailyActivityModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class DailyActivityModel {
  DailyActivityModel({
    required this.error,
    required this.status,
    required this.sportActivities,
    required this.otherActivities,
  });

  int error;
  String status;
  List<Activity> sportActivities;
  List<Activity> otherActivities;

  factory DailyActivityModel.fromJson(Map<String, dynamic> json) => DailyActivityModel(
    error: json["error"],
    status: json["status"],
    sportActivities: List<Activity>.from(json["sport_activities"].map((x) => Activity.fromJson(x))),
    otherActivities: List<Activity>.from(json["other_activities"].map((x) => Activity.fromJson(x))),
  );
}

class Activity {
  Activity({
    required this.activityId,
    required this.teacherName,
    required this.activityTitle,
    required this.activitySubject,
    required this.activityDescription,
    required this.activityImage,
  });

  int activityId;
  String teacherName;
  String activityTitle;
  String activitySubject;
  String activityDescription;
  String activityImage;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    activityId: json["activity_id"],
    teacherName: json["teacher_name"],
    activityTitle: json["activity_title"],
    activitySubject: json["activity_subject"],
    activityDescription: json["activity_description"],
    activityImage: json["activity_image"],
  );

  Map<String, dynamic> toJson() => {
    "activity_id": activityId,
    "teacher_name": teacherName,
    "activity_title": activityTitle,
    "activity_subject": activitySubject,
    "activity_description": activityDescription,
    "activity_image": activityImage,
  };
}
