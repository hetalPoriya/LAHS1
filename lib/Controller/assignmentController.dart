import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/teacherAssignmentModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class AssignmentController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var past_assignments = [].obs;
  var submitted_assignments = [].obs;
  var pending_assignments = [].obs;
  var checked_assignments = [].obs;
  var unchecked_assignments = [].obs;
  var all_assignments = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuAssignment() async {
    try{
      isLoading(true);
      print("Inside Assignment Controller");
      ToAssignmentModel toAssignmentModel = ToAssignmentModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(assignmentModelToJson(toAssignmentModel), "student_assignments");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var assignment_details = assignmentModelFromJson(response);
        status = RxString(assignment_details.status);
        error(assignment_details.error);
        past_assignments(assignment_details.pastAssignments);
        submitted_assignments(assignment_details.submittedAssignments);
        pending_assignments(assignment_details.pendingAssignments);
        pending_assignments.forEach((item) {
          print('Subject Name: ${item.subjectName}');
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

  Future getTeacherAssignment() async {
    try{
      isLoading(true);
      print("Inside Teacher Assignment Controller");
      ToTeacherAssignmentModel toTeacherAssignmentModel = ToTeacherAssignmentModel(teacherId: loginController.teacherId.value);
      var response = await NetworkHandler.post(teacherAssignmentModelToJson(toTeacherAssignmentModel), "teacher_assignments");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var assignment_details = teacherAssignmentModelFromJson(response);
        status = RxString(assignment_details.status);
        error(assignment_details.error);
        checked_assignments(assignment_details.checkedAssignments);
        unchecked_assignments(assignment_details.uncheckedAssignments);
        all_assignments(assignment_details.allUploadedAssignments);
        checked_assignments.forEach((item) {
          print('assignment_title: ${item.assignmentTitle}');
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