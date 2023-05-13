import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/assesmentCertModel.dart';
import 'package:little_angels/Model/notificationModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class NotificationController extends GetxController{
  var isLoading = false.obs;
  var error = 0.obs;
  var status = ''.obs;
  var notifications = [].obs;
  var unviewedNotification = 0.obs;
  var loginController = Get.put(LoginController());
  Future getStuNotification() async {
    try{
      isLoading(true);
      print("Inside Student Notification Controller");
      ToNotificationModel toNotificationModel = ToNotificationModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(notificationModelToJson(toNotificationModel), "student_notifications");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var notification_details = notificationModelFromJson(response);
        status = RxString(notification_details.status);
        error(notification_details.error);
        notifications(notification_details.notifications);
        unviewedNotification(notification_details.unviewedNotifications);
        notifications.forEach((item) {
          print('message: ${item.message}');
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
}