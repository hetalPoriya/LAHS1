import 'dart:convert';

import 'package:get/get.dart';
import 'package:little_angels/Model/teacherVideoModel.dart';
import '../Model/assignmentModel.dart';
import '../Model/videoModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class VideoController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  RxMap videos = {}.obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuVideos() async {
    try{
      isLoading(true);
      print("Inside Video Controller");
      ToVideoModel toVideoModel = ToVideoModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(videoModelToJson(toVideoModel), "student_videos");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1) {
        var video_details = videoModelFromJson(response);
        status = RxString(video_details.status);
        error(video_details.error);
        videos(video_details.videos);
        print(videos.keys.length);
        for (var entry in videos.entries) {
          print(entry.key);
          print(entry.value);
          for (var videoentry in entry.value){
            print(videoentry["video_link"]);
          }
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
  Future getTeacherVideos() async {
    try{
      isLoading(true);
      print("Inside Teacher Video Controller");
      ToTeacherVideoModel toVideoModel = ToTeacherVideoModel(teacherId: loginController.teacherId.value);
      var response = await NetworkHandler.post(teacherVideoModelToJson(toVideoModel), "view_uploaded_videos");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1) {
        var video_details = teacherVideoModelFromJson(response);
        status = RxString(video_details.status);
        error(video_details.error);
        videos(video_details.videos);
        print(videos.keys.length);
        print(videos.values.elementAt(0)[1]["video_description"]);
        for (var entry in videos.entries) {
          print(entry.key);
          print(entry.value);
          for (var videoentry in entry.value){
            print(videoentry["video_link"]);
          }
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