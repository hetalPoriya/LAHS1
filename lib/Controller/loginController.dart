import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_angels/Model/teacherLoginModel.dart';

import '../Model/loginModel.dart';
import '../utils/network_handler.dart';
class LoginController extends GetxController {
  var status = "".obs;
  var details = [].obs;
  var siblingStatus = "".obs;
  var teacherId = 0.obs;
  var teacherName = "".obs;
  var studentId = 0.obs;
  var studentName = "".obs;
  var siblingId = 0.obs;
  var addmissionId = "".obs;
  var email = "".obs;
  var className = "".obs;
  var sectionName = "".obs;
  var gender = "".obs;
  var dob = DateTime.now().obs;
  var contactNo = "".obs;
  var picture = "".obs;
  var siblingDetails = [].obs;
  var isLoading = false.obs;
  var error = 0.obs;
  var loginEmail = "".obs;
  var loginPassword = "".obs;
  var deviceId = "".obs;
  var androidToken = "".obs;
  var iosToken = "".obs;
  var bearerToken = "".obs;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future login() async {
    try{
      isLoading(true);
      print("Inside Login Controller");
      ToLoginModel toLoginModel = ToLoginModel(email: loginEmailController.text, password: passwordController.text, androidToken: androidToken.value, iosToken: iosToken.value, deviceId: deviceId.value);
      var response = await NetworkHandler.post(loginModelToJson(toLoginModel), "new_login");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1 && data["status"] == "0"){
        print("Inside Student Controller");
        var user_details = loginModelFromJson(response);
        status = RxString(user_details.status);
        siblingStatus = RxString(user_details.siblingStatus);
        studentId(user_details.details.studentId);
        studentName = RxString(user_details.details.studentName);
        email = RxString(user_details.details.email);
        className = RxString(user_details.details.className);
        sectionName = RxString(user_details.details.sectionName);
        gender = RxString(user_details.details.gender);
        dob(user_details.details.dob);
        addmissionId = RxString(user_details.details.addmissionId);
        siblingId(user_details.details.siblingId);
        siblingDetails(user_details.siblingDetails);
        error(user_details.error);
        bearerToken(user_details.token.plainTextToken);
        print(status);
        print(siblingStatus);
        NetworkHandler.storeToken("bearerToken",bearerToken.value);
        NetworkHandler.storeToken("emailToken",loginEmailController.text);
        NetworkHandler.storeToken("passwordToken",passwordController.text);
        NetworkHandler.storeToken("androidToken",androidToken.value);
        NetworkHandler.storeToken("iosToken",iosToken.value);
        NetworkHandler.storeToken("deviceId",deviceId.value);
      }
      else if(data["error"] == 1 && data["status"] == "1"){
        print("Inside Teacher Controller");
        var user_details = teacherLoginModelFromJson(response);
        status = RxString(user_details.status);
        //siblingStatus = RxString(user_details.siblingStatus);
        teacherId(user_details.details.teacherId);
        teacherName = RxString(user_details.details.teacherName);
        email = RxString(user_details.details.email);
        className = RxString(user_details.details.className);
        sectionName = RxString(user_details.details.sectionName);
        gender = RxString(user_details.details.gender);
        dob(user_details.details.dob);
        contactNo = RxString(user_details.details.contactNo);
        picture = RxString(user_details.details.picture);
        bearerToken(user_details.token.plainTextToken);
        //siblingDetails(user_details.siblingDetails);
        error(user_details.error);
        print(status);
        //print(siblingStatus);
        NetworkHandler.storeToken("bearerToken",bearerToken.value);
        NetworkHandler.storeToken("emailToken",loginEmailController.text);
        NetworkHandler.storeToken("passwordToken",passwordController.text);
        NetworkHandler.storeToken("androidToken",androidToken.value);
        NetworkHandler.storeToken("iosToken",iosToken.value);
        NetworkHandler.storeToken("deviceId",deviceId.value);
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }

  Future switchProfile(int sibling_id) async {
    try{
      isLoading(true);
      print("Inside SwitchProfile Controller");
      SwitchProfileModel switchProfileModel = SwitchProfileModel(sibling_id: sibling_id);
      var response = await NetworkHandler.post(switchProfileModelToJson(switchProfileModel), "new_login");
      var data = json.decode(response);
      //print(data);
      print(data["error"]);
      if(data["error"] == 1){
        var user_details = loginModelFromJson(response);
        status = RxString(user_details.status);
        siblingStatus = RxString(user_details.siblingStatus);
        studentId(user_details.details.studentId);
        studentName = RxString(user_details.details.studentName);
        email = RxString(user_details.details.email);
        className = RxString(user_details.details.className);
        sectionName = RxString(user_details.details.sectionName);
        gender = RxString(user_details.details.gender);
        dob(user_details.details.dob);
        addmissionId = RxString(user_details.details.addmissionId);
        siblingId(user_details.details.siblingId);
        siblingDetails(user_details.siblingDetails);
        error(user_details.error);
        bearerToken(user_details.token.plainTextToken);
        print(status);
        print(siblingStatus);
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }

  Future loggedin() async {
    try{
      isLoading(true);
      print("Inside loggedin Controller");
      ToLoginModel toLoginModel = ToLoginModel(email: loginEmail.value, password: loginPassword.value, androidToken: androidToken.value, iosToken: iosToken.value, deviceId: deviceId.value);
      var response = await NetworkHandler.post(loginModelToJson(toLoginModel), "new_login");
      var data = json.decode(response);
      print(data);
      print(data["error"]);
      if(data["error"] == 1 && data["status"] == "0"){
        print("Inside Student Controller");
        var user_details = loginModelFromJson(response);
        status = RxString(user_details.status);
        siblingStatus = RxString(user_details.siblingStatus);
        studentId(user_details.details.studentId);
        studentName = RxString(user_details.details.studentName);
        email = RxString(user_details.details.email);
        className = RxString(user_details.details.className);
        sectionName = RxString(user_details.details.sectionName);
        gender = RxString(user_details.details.gender);
        dob(user_details.details.dob);
        addmissionId = RxString(user_details.details.addmissionId);
        siblingId(user_details.details.siblingId);
        siblingDetails(user_details.siblingDetails);
        error(user_details.error);
        bearerToken(user_details.token.plainTextToken);
        print("Token "+user_details.token.plainTextToken);
        print(status);
        print(siblingStatus);
        print(siblingDetails.length);
        for(var i=0; i<siblingDetails.length; i++){
          print(siblingDetails[i][0].studentName);
        }
      }
      else if(data["error"] == 1 && data["status"] == "1"){
        print("Inside Teacher Controller");
        var user_details = teacherLoginModelFromJson(response);
        print("Token "+user_details.token.plainTextToken);
        status = RxString(user_details.status);
        teacherId(user_details.details.teacherId);
        teacherName = RxString(user_details.details.teacherName);
        email = RxString(user_details.details.email);
        className = RxString(user_details.details.className);
        sectionName = RxString(user_details.details.sectionName);
        gender = RxString(user_details.details.gender);
        dob(user_details.details.dob);
        contactNo = RxString(user_details.details.contactNo);
        picture = RxString(user_details.details.picture);
        bearerToken(user_details.token.plainTextToken);
        error(user_details.error);
        print(status);
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }
}