import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/documentModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class DocumentController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  RxMap docdata = {}.obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuDecument() async {
    try{
      isLoading(true);
      print("Inside Document Controller");
      ToDocumentModel toDocumentModel = ToDocumentModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(documentModelToJson(toDocumentModel), "student_view_documents");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var documet_details = documentModelFromJson(response);
        status = RxString(documet_details.status);
        error(documet_details.error);
        docdata(documet_details.data);
        for (var entry in docdata.entries) {
          print(entry.key);
          print(entry.value);
          print(entry.value["year_folder"]);
          print(entry.value["month_folder"][0]["folder_name"]);
          print(entry.value["month_folder"].length);
          print(entry.value["month_folder"][4]["documents"].length);
        }
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