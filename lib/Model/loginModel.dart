// To parse required this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(ToLoginModel data) => json.encode(data.toJson());

String switchProfileModelToJson(SwitchProfileModel data) => json.encode(data.toJson());

class SwitchProfileModel {
  SwitchProfileModel({
    required this.sibling_id
  });
  int sibling_id;
  Map<String, dynamic> toJson() => {
    "sibling_id": sibling_id,
  };
}

class ToLoginModel {
  ToLoginModel({
    required this.email,
    required this.password,
    required this.androidToken,
    required this.iosToken,
    required this.deviceId
  });
  String email;
  String password;
  String androidToken;
  String iosToken;
  String deviceId;
  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "android_token": androidToken,
    "ios_token": iosToken,
    "device_id": deviceId,
  };
}

class LoginModel {
  LoginModel({
    required this.token,
    required this.error,
    required this.status,
    required this.details,
    required this.siblingStatus,
    required this.siblingDetails,
  });

  Token token;
  int error;
  String status;
  Details details;
  String siblingStatus;
  List<List<Details>> siblingDetails;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    token: Token.fromJson(json["token"]),
    error: json["error"],
    status: json["status"],
    details: Details.fromJson(json["details"]),
    siblingStatus: json["sibling_status"],
    siblingDetails: List<List<Details>>.from(json["sibling_details"].map((x) => List<Details>.from(x.map((x) => Details.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "token": token.toJson(),
    "error": error,
    "status": status,
    "details": details.toJson(),
    "sibling_status": siblingStatus,
    "sibling_details": List<dynamic>.from(siblingDetails.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class Details {
  Details({
    required this.studentId,
    required this.studentName,
    required this.email,
    required this.className,
    required this.sectionName,
    required this.gender,
    required this.dob,
    required this.addmissionId,
    required this.siblingId,
  });

  int studentId;
  String studentName;
  String email;
  String className;
  String sectionName;
  String gender;
  DateTime dob;
  String addmissionId;
  int siblingId;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    studentId: json["student_id"] == null ? null : json["student_id"],
    studentName: json["student_name"],
    email: json["email"],
    className: json["class_name"],
    sectionName: json["section_name"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    addmissionId: json["addmission_id"],
    siblingId: json["sibling_id"] == null ? null : json["sibling_id"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId == null ? null : studentId,
    "student_name": studentName,
    "email": email,
    "class_name": className,
    "section_name": sectionName,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "addmission_id": addmissionId,
    "sibling_id": siblingId == null ? null : siblingId,
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
