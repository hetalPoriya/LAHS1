// To parse this JSON data, do
//
//     final todaysWorkModel = todaysWorkModelFromJson(jsonString);

import 'dart:convert';

TodaysWorkModel todaysWorkModelFromJson(String str) => TodaysWorkModel.fromJson(json.decode(str));

String todaysWorkModelToJson(ToTodaysWorkModel data) => json.encode(data.toJson());

class ToTodaysWorkModel {
  ToTodaysWorkModel({
    required this.studentId
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class TodaysWorkModel {
  TodaysWorkModel({
    required this.error,
    required this.status,
    required this.todayWork,
  });

  int error;
  String status;
  List<Work> todayWork;

  factory TodaysWorkModel.fromJson(Map<String, dynamic> json) => TodaysWorkModel(
    error: json["error"],
    status: json["status"],
    todayWork: List<Work>.from(json["today_work"].map((x) => Work.fromJson(x))),
  );
}

class Work {
  Work({
    required this.subjectsName,
    required this.description,
    required this.workDate,
  });

  String subjectsName;
  String description;
  DateTime workDate;

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    subjectsName: json["subjects_name"],
    description: json["description"],
    workDate: DateTime.parse(json["work_date"]),
  );
}
