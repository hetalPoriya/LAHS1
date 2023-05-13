import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/teacherAssignmentModel.dart';
import 'package:little_angels/Model/todaysWorkModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class TodaysWorkController extends GetxController {
  var error = 0.obs;
  var status = ''.obs;
  var todayWork = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuTodaysWork() async {
    try {
      isLoading(true);
      print("Inside TodaysWork Controller");
      ToTodaysWorkModel toTodaysWorkModel =
          ToTodaysWorkModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(
          todaysWorkModelToJson(toTodaysWorkModel), "student_today_work");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if (data["error"] == 1) {
        var todays_work_details = todaysWorkModelFromJson(response);
        status = RxString(todays_work_details.status);
        error(todays_work_details.error);
        todayWork(todays_work_details.todayWork);
      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }
}
