// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/notificationController.dart';
import 'package:little_angels/Student/edit_profile.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/network_handler.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../utils/colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var notificationController = Get.put(NotificationController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      notificationController.getStuNotification();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: Padding(
            padding: const EdgeInsets.only(top: 60,),
            child:
            Obx(
            () => notificationController.isLoading ==true?
            Center(
            child: Image.asset(
            "assets/loading.gif",
            height: 425.0,
            width: 425.0,
            fit: BoxFit.fitHeight,
            ),
            ):Column(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "NOTIFICATIONS",
                style: titleTextStyle,
              ),
              divider,
              Expanded(
                child:
              MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      // removeBottom: true,
                      // removeBottom: true,
                      child: notificationController.notifications.length==0?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/no-data.gif"),
                    smallSizedBox,
                    Text("Notifications not found", style: TextStyle(color: Colors.purple[800]),)
                  ],
                ): notificationController.status == "Notifications not found"?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no-data.gif"),
                  smallSizedBox,
                  Text("Notifications not found", style: TextStyle(color: Colors.purple[800]),)
                ],
              ):ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: notificationController.notifications.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: ColorConstants.kGreyColor100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  smallerSizedBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        notificationController.notifications[index].title!=null?
                                        notificationController.notifications[index].title:"",
                                        style:const  TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Center(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(notificationController.notifications[index].createdAt),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  mediumSizedBox,
                                  Text(
                                    notificationController.notifications[index].message,
                                  ),
                                  smallerSizedBox,
                                ],
                              ),
                            ),
                          );
                        },
                      ),),),
                ]
           ))));
        
  }
}
