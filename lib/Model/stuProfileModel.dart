// To parserequired this JSON data, do
//
//     final stuProfileModel = stuProfileModelFromJson(jsonString);

import 'dart:convert';

StuProfileModel stuProfileModelFromJson(String str) => StuProfileModel.fromJson(json.decode(str));

String stuProfileModelToJson(ToStuProfileModel data) => json.encode(data.toJson());

class ToStuProfileModel {
  ToStuProfileModel({
    required this.studentId
});
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class StuProfileModel {
  StuProfileModel({
   required this.error,
   required this.status,
   required this.studentDetails,
  });

  int error;
  String status;
  List<StudentDetail> studentDetails;

  factory StuProfileModel.fromJson(Map<String, dynamic> json) => StuProfileModel(
    error: json["error"],
    status: json["status"],
    studentDetails: List<StudentDetail>.from(json["student_details"].map((x) => StudentDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "student_details": List<dynamic>.from(studentDetails.map((x) => x.toJson())),
  };
}

class StudentDetail {
  StudentDetail({
   required this.studentName,
   required this.studentDetailClass,
   required this.studentId,
   required this.gender,
   required this.dob,
   required this.parentsName,
   required this.sectionName,
   required this.fatherContactNo,
  });

  String studentName;
  String studentDetailClass;
  int studentId;
  String gender;
  DateTime dob;
  String parentsName;
  String sectionName;
  String fatherContactNo;

  factory StudentDetail.fromJson(Map<String, dynamic> json) => StudentDetail(
    studentName: json["student_name"],
    studentDetailClass: json["class"],
    studentId: json["student_id"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    parentsName: json["parents_name"],
    sectionName: json["section_name"],
    fatherContactNo: json["father_contact_no"],
  );

  Map<String, dynamic> toJson() => {
    "student_name": studentName,
    "class": studentDetailClass,
    "student_id": studentId,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "parents_name": parentsName,
    "section_name": sectionName,
    "father_contact_no": fatherContactNo,
  };
}
