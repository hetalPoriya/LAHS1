// To parse required this JSON data, do
//
//     final teacherLoginModel = teacherLoginModelFromJson(jsonString);

import 'dart:convert';

TeacherLoginModel teacherLoginModelFromJson(String str) => TeacherLoginModel.fromJson(json.decode(str));

String teacherLoginModelToJson(TeacherLoginModel data) => json.encode(data.toJson());

class TeacherLoginModel {
  TeacherLoginModel({
    required this.token,
    required this.error,
    required this.status,
    required this.details,
    required this.siblingStatus,
  });

  Token token;
  int error;
  String status;
  Details details;
  String siblingStatus;

  factory TeacherLoginModel.fromJson(Map<String, dynamic> json) => TeacherLoginModel(
    token: Token.fromJson(json["token"]),
    error: json["error"],
    status: json["status"],
    details: Details.fromJson(json["details"]),
    siblingStatus: json["sibling_status"],
  );

  Map<String, dynamic> toJson() => {
    "token": token.toJson(),
    "error": error,
    "status": status,
    "details": details.toJson(),
    "sibling_status": siblingStatus,
  };
}

class Details {
  Details({
    required this.teacherId,
    required this.teacherName,
    required this.email,
    required this.className,
    required this.sectionName,
    required this.gender,
    required this.dob,
    required this.contactNo,
    required this.picture,
  });

  int teacherId;
  String teacherName;
  String email;
  String className;
  String sectionName;
  String gender;
  DateTime dob;
  String contactNo;
  String picture;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    teacherId: json["teacher_id"],
    teacherName: json["teacher_name"],
    email: json["email"],
    className: json["class_name"],
    sectionName: json["section_name"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    contactNo: json["contact_no"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "teacher_id": teacherId,
    "teacher_name": teacherName,
    "email": email,
    "class_name": className,
    "section_name": sectionName,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "contact_no": contactNo,
    "picture": picture,
  };
}

class Token {
  Token({
    required this.accessToken,
    required this.plainTextToken,
  });

  AccessToken accessToken;
  String plainTextToken;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: AccessToken.fromJson(json["accessToken"]),
    plainTextToken: json["plainTextToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken.toJson(),
    "plainTextToken": plainTextToken,
  };
}

class AccessToken {
  AccessToken({
    required this.name,
    required this.abilities,
    required this.tokenableId,
    required this.tokenableType,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String name;
  List<String> abilities;
  int tokenableId;
  String tokenableType;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
    name: json["name"],
    abilities: List<String>.from(json["abilities"].map((x) => x)),
    tokenableId: json["tokenable_id"],
    tokenableType: json["tokenable_type"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "abilities": List<dynamic>.from(abilities.map((x) => x)),
    "tokenable_id": tokenableId,
    "tokenable_type": tokenableType,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}