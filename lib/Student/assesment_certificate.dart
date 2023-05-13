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
import '../utils/widgets/shimmerWidget.dart';

class AssesmentCertificate extends StatefulWidget {

  const AssesmentCertificate({Key? key}) : super(key: key);

  @override
  State<AssesmentCertificate> createState() => _AssesmentCertificateState();
}

class _AssesmentCertificateState extends State<AssesmentCertificate> {
  DateTime todayDate = DateTime.now();
  NetworkHandler nr = NetworkHandler();
  var assesmentCertController = Get.put(AssesmentCertController());
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Assesment Certificate", style: titleTextStyle),
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
    return Obx(() => assesmentCertController.isLoading ==true?
    Center(
      child: Image.asset(
        "assets/loading.gif",
        height: 425.0,
        width: 425.0,
        fit: BoxFit.fitHeight,
      ),
    ):Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: assesmentCertController.status == "Certificate not found"?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/no-data.gif"),
            smallSizedBox,
            Text("Certificate not found", style: TextStyle(color: Colors.purple[800]),)
          ],
        ):ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 15,
                              //childAspectRatio: 16 / 9,
                            ),
                            itemCount: assesmentCertController.certificates.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                AnimatedNavigation.pushAnimatedNavigation(
                                  context,
                                  ShowImage(
                                      url: assesmentCertController.certificates[index].certificateFile),
                                );
                              },
                              child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  smallSizedBox,
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl: assesmentCertController.certificates[index].certificateFile,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height/6,
                                          width: MediaQuery.of(context).size.width,
                                          placeholder: (context, url) => buildShimmer(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ),
                          ),
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