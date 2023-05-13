import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/teacherMessageModel.dart';
import '../Model/messageModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class MessageController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var inbox_message = [].obs;
  var outbox_message = [].obs;
  var msgIsLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuMessages() async {
    try{
      msgIsLoading(true);
      print("Inside Student Message Controller");
      ToMessageModel toMessageModel = ToMessageModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(messageModelToJson(toMessageModel), "student_messages");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var message_details = messageModelFromJson(response);
        status = RxString(message_details.status);
        error(message_details.error);
        inbox_message(message_details.inboxMessages);
        outbox_message(message_details.outboxMessages);
        print(status);
        inbox_message.forEach((item) {
          print('messageId: ${item.messageId}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      msgIsLoading(false);
    }
  }
  Future getTeacherMessages() async {
    try{
      msgIsLoading(true);
      print("Inside Teacher Message Controller");
      ToTeacherMessageModel toTeacherMessageModel = ToTeacherMessageModel(teacherId: loginController.teacherId.value);
      var response = await NetworkHandler.post(teacherMessageModelToJson(toTeacherMessageModel), "teacher_messages");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var message_details = teacherMessageModelFromJson(response);
        status = RxString(message_details.status);
        error(message_details.error);
        inbox_message(message_details.inboxMessages);
        outbox_message(message_details.outboxMessages);
        print(status);
        inbox_message.forEach((item) {
          print('messageId: ${item.messageId}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      msgIsLoading(false);
    }
  }
}