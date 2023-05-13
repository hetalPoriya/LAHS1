// To parse this JSON data, do
//
//     final calEventModel = calEventModelFromJson(jsonString);

import 'dart:convert';

CalEventModel calEventModelFromJson(String str) => CalEventModel.fromJson(json.decode(str));

String calEventModelToJson(ToCalEventModel data) => json.encode(data.toJson());

class ToCalEventModel {
  ToCalEventModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class CalEventModel {
  CalEventModel({
    required this.error,
    required this.status,
    required this.calenderEvents,
  });

  int error;
  String status;
  List<CalenderEvent> calenderEvents;

  factory CalEventModel.fromJson(Map<String, dynamic> json) => CalEventModel(
    error: json["error"],
    status: json["status"],
    calenderEvents: List<CalenderEvent>.from(json["calender_events"].map((x) => CalenderEvent.fromJson(x))),
  );
}

class CalenderEvent {
  CalenderEvent({
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
  });

  String eventTitle;
  String eventDescription;
  DateTime eventDate;

  factory CalenderEvent.fromJson(Map<String, dynamic> json) => CalenderEvent(
    eventTitle: json["event_title"],
    eventDescription: json["event_description"],
    eventDate: DateTime.parse(json["event_date"]),
  );

  Map<String, dynamic> toJson() => {
    "event_title": eventTitle,
    "event_description": eventDescription,
    "event_date": "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
  };
}
