import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/videoController.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/network_handler.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/show_image.dart';
import 'package:little_angels/utils/widgets/video_player.dart';
import 'package:little_angels/utils/widgets/youtube_video_player.dart';

import '../Controller/assesmentCertController.dart';
import '../Controller/loginController.dart';
import '../utils/widgets/shimmerWidget.dart';
import 'home_page.dart';

class SwitchProfile extends StatefulWidget {

  const SwitchProfile({Key? key}) : super(key: key);

  @override
  State<SwitchProfile> createState() => _SwitchProfileState();
}

class _SwitchProfileState extends State<SwitchProfile> {
  DateTime todayDate = DateTime.now();
  NetworkHandler nr = NetworkHandler();
  var loginController = Get.put(LoginController());
  @override
  void initState() {
    //_init();
    super.initState();
  }

  /*_init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      assesmentCertController.getStuCertificate();
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
  }*/

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Switch Profile", style: titleTextStyle),
                smallSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      style: textButtonTextStyle,
                    ),
                  ],
                ),
                divider,
                const SizedBox(height: 10),
                buildTabBarView(),
              ],
            ),
          ),
        );
    //   ),
    // );
  }

  buildTabBarView() {
    return Obx(() => loginController.isLoading ==true?
    Container(
      padding: EdgeInsets.all(0),
        height: MediaQuery.of(context).size.height/2,
        child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/switch-profile.png",
              height: 100.0,
              width: 100.0,
              fit: BoxFit.fitHeight,
            ),
            largerSizedBox,
            Text("Switching Account..")
          ],
        )
    )):Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 16 / 22,
                      ),
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.deepPurple)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              smallSizedBox,
                              loginController.gender == "male"?ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset("assets/profile/profile_male.png", height: 90,),
                              ):
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset("assets/profile/profile_female.png", height: 90,),
                              ),
                              mediumSizedBox,
                              Text("${loginController.studentName.value}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
                              smallerSizedBox,
                              Text("DOB: ${DateFormat('dd MMMM yyyy').format(loginController.dob.value)}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),),
                              smallerSizedBox,
                              Text("Class: ${loginController.className} ${loginController.sectionName}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),),
                            ],
                          ),
                        ),
                        for (var index = 0; index<loginController.siblingDetails.length; index++)...{
                          Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: InkWell(
                              onTap: ()async {
                                bool isConnected = await nr.checkConnectivity();
                                print(isConnected);
                                if (isConnected) {
                                  await loginController.switchProfile(loginController.siblingDetails[index][0].siblingId);
                                  Get.offAll(StudentHome());
                                }
                                else{
                                  Navigator.pop(context);
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
                              },
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                smallSizedBox,
                                loginController.siblingDetails[index][0].gender == "male"?ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset("assets/profile/profile_male.png", height: 90,),
                                ):
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset("assets/profile/profile_female.png", height: 90,),
                                ),
                                mediumSizedBox,
                                Text("${loginController.siblingDetails[index][0].studentName}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
                                smallerSizedBox,
                                Text("DOB: ${DateFormat('dd MMMM yyyy').format(loginController.siblingDetails[index][0].dob)}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),),
                                smallerSizedBox,
                                Text("Class: ${loginController.siblingDetails[index][0].className} ${loginController.siblingDetails[index][0].sectionName}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),),
                              ],
                            ),)
                          )
                        }
                      ],),
                    smallSizedBox,
                  ],
                ),
      ),
    ));
  }
  Widget buildShimmer(){
    return Container(
      height: MediaQuery.of(context).size.height/6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorConstants.kWhiteColor,
          borderRadius: BorderRadius.circular(
              10.0)),
      child: Center(
          child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height/6,
            width: MediaQuery.of(context).size.width,)
      ),
    );
  }
}