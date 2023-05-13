import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:little_angels/Model/assesmentCertModel.dart';
import 'package:little_angels/Model/stuCompMsgModel.dart';
import 'package:little_angels/Model/studentsByClassSectionModel.dart';
import 'package:little_angels/Model/teacherClassesSectionsModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class TeacherNewMsgController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var classesSections = [].obs;
  var students = [].obs;
  var studentVisible = false.obs;
  var isLoading = false.obs;
  var isMsgSent = false.obs;
  var classId = 0.obs;
  var sectionId = 0.obs;
  var studentId = 0.obs;
  var isStudentLoading = false.obs;
  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();
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
  Future teacherSendMessage() async {
    try{
      isMsgSent(true);
      print("Inside teacherSendMessage Controller");
      ToStuCompMsgModel toStuCompMsgModel = ToStuCompMsgModel(teacherId: loginController.teacherId.value, studentId: studentId.value, message: message.text, title: title.text);
      var response = await NetworkHandler.post(stuCompMsgModelToJson(toStuCompMsgModel), "teacher_send_message");
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
      message.clear();
      title.clear();
    }
  }
}