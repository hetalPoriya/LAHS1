// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(ToVideoModel data) => json.encode(data.toJson());

class ToVideoModel {
  ToVideoModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class VideoModel {
  VideoModel({
    required this.error,
    required this.status,
    required this.videos,
  });

  int error;
  String status;
  Map<String, dynamic> videos;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    error: json["error"],
    status: json["status"],
    videos: json["videos"],
  );
}

class Video {
  Video({
    required this.videoLink,
    required this.videoDescription,
    required this.subjectId,
    required this.subjectName,
  });

  String videoLink;
  String videoDescription;
  int subjectId;
  String subjectName;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    videoLink: json["video_link"],
    videoDescription: json["video_description"],
    subjectId: json["subject_id"],
    subjectName: json["subject_name"],
  );

  Map<String, dynamic> toJson() => {
    "video_link": videoLink,
    "video_description": videoDescription,
    "subject_id": subjectId,
    "subject_name": subjectName,
  };
}
