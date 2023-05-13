// To parse this JSON data, do
//
//     final pickupCardModel = pickupCardModelFromJson(jsonString);

import 'dart:convert';

PickupCardModel pickupCardModelFromJson(String str) => PickupCardModel.fromJson(json.decode(str));

String pickupCardModelToJson(ToPickupCardModel data) => json.encode(data.toJson());

class ToPickupCardModel {
  ToPickupCardModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class PickupCardModel {
  PickupCardModel({
    required this.error,
    required this.status,
    required this.pickupCardDetails,
  });

  int error;
  String status;
  Map<String, dynamic> pickupCardDetails;

  factory PickupCardModel.fromJson(Map<String, dynamic> json) => PickupCardModel(
    error: json["error"],
    status: json["status"],
    pickupCardDetails: json["pickup_card_details"],
  );
}

class PickupCardDetails {
  PickupCardDetails({
    required this.studentDetails,
    required this.guardianDetails,
  });

  List<StudentDetail> studentDetails;
  List<GuardianDetail> guardianDetails;

  factory PickupCardDetails.fromJson(Map<String, dynamic> json) => PickupCardDetails(
    studentDetails: List<StudentDetail>.from(json["student_details"].map((x) => StudentDetail.fromJson(x))),
    guardianDetails: List<GuardianDetail>.from(json["guardian_details"].map((x) => GuardianDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "student_details": List<dynamic>.from(studentDetails.map((x) => x.toJson())),
    "guardian_details": List<dynamic>.from(guardianDetails.map((x) => x.toJson())),
  };
}

class GuardianDetail {
  GuardianDetail({
    required this.id,
    required this.pickupCardId,
    required this.name,
    required this.relation,
    required this.contact,
    required this.aadharNo,
    required this.photo,
  });

  int id;
  int pickupCardId;
  String name;
  String relation;
  String contact;
  String aadharNo;
  String photo;

  factory GuardianDetail.fromJson(Map<String, dynamic> json) => GuardianDetail(
    id: json["id"],
    pickupCardId: json["pickup_card_id"],
    name: json["name"],
    relation: json["relation"],
    contact: json["contact"],
    aadharNo: json["aadhar_no"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pickup_card_id": pickupCardId,
    "name": name,
    "relation": relation,
    "contact": contact,
    "aadhar_no": aadharNo,
    "photo": photo,
  };
}

class StudentDetail {
  StudentDetail({
    required this.teacherApproved,
    required this.adminApproved,
    required this.pickupCardId,
    required this.studentPhoto,
    required this.className,
    required this.sectionName,
    required this.studentGender,
    required this.studentDob,
  });

  int teacherApproved;
  int adminApproved;
  int pickupCardId;
  String studentPhoto;
  String className;
  String sectionName;
  String studentGender;
  DateTime studentDob;

  factory StudentDetail.fromJson(Map<String, dynamic> json) => StudentDetail(
    teacherApproved: json["teacher_approved"],
    adminApproved: json["admin_approved"],
    pickupCardId: json["pickup_card_id"],
    studentPhoto: json["student_photo"],
    className: json["class_name"],
    sectionName: json["section_name"],
    studentGender: json["student_gender"],
    studentDob: DateTime.parse(json["student_dob"]),
  );

  Map<String, dynamic> toJson() => {
    "teacher_approved": teacherApproved,
    "admin_approved": adminApproved,
    "pickup_card_id": pickupCardId,
    "student_photo": studentPhoto,
    "class_name": className,
    "section_name": sectionName,
    "student_gender": studentGender,
    "student_dob": "${studentDob.year.toString().padLeft(4, '0')}-${studentDob.month.toString().padLeft(2, '0')}-${studentDob.day.toString().padLeft(2, '0')}",
  };
}
