// ignore_for_file: unused_import

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/reportCardController.dart';
import 'package:little_angels/Student/change_request.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/network_handler.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/widgets/show_image.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({Key? key}) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  DateTime todayDate = DateTime.now();
  var reportCardController = Get.put(ReportCardController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    // TODO: implement initState
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      reportCardController.getStuReportCard();
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
            Text("Report Card", style: titleTextStyle),
            smallSizedBox,
            Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: textButtonTextStyle,
            ),
            divider,
            mediumSizedBox,
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Obx(
                  () => reportCardController.isLoading ==true?
              Center(
                child: Image.asset(
                  "assets/loading.gif",
                  height: 425.0,
                  width: 425.0,
                  fit: BoxFit.fitHeight,
                ),
              ):
                  reportCardController.report_card.length==0?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/no-data.gif"),
                smallSizedBox,
                Text("Report card not found", style: TextStyle(color: Colors.purple[800]),)
              ],
            ): reportCardController.status == "Report card not found"?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-data.gif"),
              smallSizedBox,
              Text("Report card found", style: TextStyle(color: Colors.purple[800]),)
            ],
          ): ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    //childAspectRatio: 16 / 9,
                  ),
                  itemCount: reportCardController.report_card.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        _launchUrl(reportCardController.report_card[index].reportCardFile);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          largeSizedBox,
                          SizedBox(
                              height: MediaQuery.of(context).size.height/5.7,
                            child:
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  "assets/pdf-file.png",
                                  fit: BoxFit.fill,
                                  //height: MediaQuery.of(context).size.height/6,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                            ),
                          ),
                          )
                        ],
                      )
                  ),
                ),
                largeSizedBox,
              ],
            ),
          ),
          )
        ),
            smallSizedBox,
            /*Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Download",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: const Color.fromRGBO(105, 80, 255, 1.0),
                      ),
                    ),
                    //SizedBox(height: 10),
                  ],
                ),
              ),
            ),*/
           
      ],
      ),
      ),
      );
    //   ),
    // );
  }
  _launchUrl(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could not launch $url';
    }
  }
}

 