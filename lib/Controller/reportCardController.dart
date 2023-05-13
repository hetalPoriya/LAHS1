import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/reportCardModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class ReportCardController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var report_card = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuReportCard() async {
    try{
      isLoading(true);
      print("Inside Report Card Controller");
      ToReportCardModel toReportCardModel = ToReportCardModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(reportCardModelToJson(toReportCardModel), "student_report_card_list");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var reportCard_details = reportCardModelFromJson(response);
        status = RxString(reportCard_details.status);
        error(reportCard_details.error);
        report_card(reportCard_details.reportCards);
        report_card.forEach((item) {
          print('ReportCard File: ${item.reportCardFile}');
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