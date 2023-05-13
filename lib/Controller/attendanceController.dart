import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/attendanceModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class AttendanceController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var attendance = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());

  Future getAttendance() async {
    try{
      isLoading(true);
      print("Inside Attendance Controller");
      ToAttendanceModel toAttendanceModel = ToAttendanceModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(attendanceModelToJson(toAttendanceModel), "view_attendance");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var attendance_details = attendanceModelFromJson(response);
        status = RxString(attendance_details.status);
        error(attendance_details.error);
        attendance(attendance_details.attendance);
        attendance.forEach((item) {
          print('status: ${item.status}');
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