import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/calEventModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class CalEventController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var calender_events = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuEvent() async {
    try{
      isLoading(true);
      print("Inside Calendar Event Controller");
      ToCalEventModel toCalEventModel = ToCalEventModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(calEventModelToJson(toCalEventModel), "student_view_event");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var event_details = calEventModelFromJson(response);
        status = RxString(event_details.status);
        error(event_details.error);
        calender_events(event_details.calenderEvents);
        calender_events.forEach((item) {
          print('event_title: ${item.eventTitle}');
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