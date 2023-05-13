// ignore_for_file: unnecessary_import

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_angels/Teacher/home.dart';
import 'package:little_angels/login_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/constants.dart';
//import 'package:little_angels/welcome_page.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/widgets/custom_splashpage.dart';

import 'Controller/loginController.dart';
import 'Student/home_page.dart';
import 'utils/network_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var loginController = Get.put(LoginController());
  var isToken;
  var isPassToken;
  var androidToken;
  var iosToken;
  var deviceIdToken;
  var route_val;
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      checkLogin();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(days: 1),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  'No internet available',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
            textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
        backgroundColor: Colors.grey,
      ));
    }
  }

  checkLogin() async {
    print("inside check login");
    isToken = await NetworkHandler.getToken("emailToken");
    isPassToken = await NetworkHandler.getToken("passwordToken");
    androidToken = await NetworkHandler.getToken("androidToken");
    iosToken = await NetworkHandler.getToken("iosToken");
    deviceIdToken = await NetworkHandler.getToken("deviceId");
    if(isToken != null){
      loginController.loginEmail(isToken);
      loginController.loginPassword(isPassToken);
      loginController.androidToken(androidToken);
      loginController.iosToken(iosToken);
      loginController.deviceId(deviceIdToken);
      print("token email is");
      print(loginController.loginEmail);
      await loginController.loggedin();
      //print("error");
      //print(loginController.error.value);
      (loginController.error.value == 1 && !loginController.isLoading.value && loginController.status.value == "0") ?
      setState((){
        route_val = StudentHome();
      }):
      (loginController.error.value == 1 && !loginController.isLoading.value && loginController.status.value == "1") ?
      setState((){
        route_val = TeacherHome();
      }):
      setState((){
        route_val = LoginPage();
      }
      );
    }
    else{
      setState((){
        route_val = LoginPage();
      }
      );
    }
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    return AnimatedNavigation.pushReplacementAnimatedNavigation(
        context, route_val);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSplashScaffold(
      showAppBar: false,
      child: Center(
        child: Image.asset(
          AssetImages.splashLogo,
          width: MediaQuery.of(context).size.width / 1.2,
        ),
      ),
    );
  }
}
