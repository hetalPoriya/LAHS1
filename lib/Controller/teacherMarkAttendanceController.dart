import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:little_angels/Model/assesmentCertModel.dart';
import 'package:little_angels/Model/markAttendanceModel.dart';
import 'package:little_angels/Model/stuCompMsgModel.dart';
import 'package:little_angels/Model/studentsByClassSectionModel.dart';
import 'package:little_angels/Model/teacherClassesSectionsModel.dart';
import 'package:little_angels/Model/teacherViewAttendanceModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class TeacherMarkAttendanceController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var classesSections = [].obs;
  var students = [].obs;
  var studentVisible = false.obs;
  var isLoading = false.obs;
  var isMsgSent = false.obs;
  var viewAttendance = false.obs;
  var classId = 0.obs;
  var dayclassId = 0.obs;
  var sectionId = 0.obs;
  var studentId = [].obs;
  var vStudentId = 0.obs;
  var isStudentLoading = false.obs;
  var attendance = [].obs;
  var attendanceMonth = 0.obs;
  TextEditingController attendanceDate = TextEditingController();
  var loginController = Get.put(LoginController());
  Future getClassesSections() async {
    try{
      isLoading(true);
      print("Inside TeacherClassesSections Controller");
      ToTeacherClassesSectionsModel toTeacherClassesSectionsModel = ToTeacherClassesSectionsModel(teacher_id: loginController.teacherId.value);
      var response = await NetworkHandler.post(teacherClassesSectionsModelToJson(toTeacherClassesSectionsModel), "get_teacher_classes_sections");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var data_details = teacherClassesSectionsModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
        classesSections(data_details.classesSections);
        classesSections.forEach((item) {
          print('className: ${item.className}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isLoading(false);
    }
  }
  Future getStudentsByClassSection() async {
    try{
      isStudentLoading(true);
      print("Inside StudentsByClassSection Controller");
      ToStudentsByClassSectionModel toStudentsByClassSectionModel = ToStudentsByClassSectionModel(class_id: classId.value,section_id: sectionId.value);
      var response = await NetworkHandler.post(studentsByClassSectionModelToJson(toStudentsByClassSectionModel), "get_students_by_class_section");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var data_details = studentsByClassSectionModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
        students(data_details.students);
        studentVisible(true);
        students.forEach((item) {
          print('studentName: ${item.studentName}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isStudentLoading(false);
    }
  }
  Future teacherMarkAttendance() async {
    try{
      isMsgSent(true);
      print("Inside teacherMarkAttendance Controller");
      ToMarkAttendanceModel toMarkAttendanceModel = ToMarkAttendanceModel(teacherId: loginController.teacherId.value, classId: classId.value, sectionId: sectionId.value, studentId: studentId, attendanceDate: attendanceDate.text);
      var response = await NetworkHandler.post(markAttendanceModelToJson(toMarkAttendanceModel), "mark_attendance");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var data_details = stuCompMsgModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
        print(error);
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isMsgSent(false);
      attendanceDate.clear();
    }
  }
  Future teacherViewAttendance() async {
    try{
      isMsgSent(true);
      print("Inside teacherViewAttendance Controller");
      ToTeacherViewAttendanceModel toTeacherViewAttendanceModel = ToTeacherViewAttendanceModel(classId: classId.value, sectionId: sectionId.value, attendanceDate: attendanceDate.text);
      var response = await NetworkHandler.post(teacherViewAttendanceModelToJson(toTeacherViewAttendanceModel), "view_day_wise_attendance");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var data_details = teacherViewAttendanceModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
        attendance(data_details.attendance);
        viewAttendance(true);
        print(error);
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isMsgSent(false);
      attendanceDate.clear();
    }
  }
  Future teacherViewStuAttendance() async {
    try{
      isMsgSent(true);
      print("Inside teacherViewStuAttendance Controller");
      ToTeacherViewAttendanceModel toTeacherViewAttendanceModel = ToTeacherViewAttendanceModel(classId: classId.value, sectionId: sectionId.value, attendanceDate: attendanceDate.text);
      var response = await NetworkHandler.post(teacherViewAttendanceModelToJson(toTeacherViewAttendanceModel), "view_day_wise_attendance");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var data_details = teacherViewAttendanceModelFromJson(response);
        status = RxString(data_details.status);
        error(data_details.error);
        attendance(data_details.attendance);
        viewAttendance(true);
        print(error);
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isMsgSent(false);
      attendanceDate.clear();
    }
  }
}