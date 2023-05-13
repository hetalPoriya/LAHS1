import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/assesmentCertModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class AssesmentCertController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var certificates = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuCertificate() async {
    try{
      isLoading(true);
      print("Inside Assesment Certificate Controller");
      ToAssessmentCertModel toAssessmentCertModel = ToAssessmentCertModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(assessmentCertModelToJson(toAssessmentCertModel), "student_certificate_list");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var cerificate_details = assessmentCertModelFromJson(response);
        status = RxString(cerificate_details.status);
        error(cerificate_details.error);
        certificates(cerificate_details.certificates);
        certificates.forEach((item) {
          print('comment: ${item.comment}');
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