// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/pickupCardController.dart';
import 'package:little_angels/Student/edit_pickUp_card.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

import '../Controller/loginController.dart';
import '../utils/network_handler.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class Pickupcard extends StatefulWidget {
  const Pickupcard({Key? key}) : super(key: key);

  @override
  State<Pickupcard> createState() => _PickupcardState();
}

class _PickupcardState extends State<Pickupcard> {
  var pickupCardController = Get.put(PickupCardController());
  NetworkHandler nr = NetworkHandler();
  var loginController = Get.put(LoginController());
  final GlobalKey genKey = GlobalKey();

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
      await pickupCardController.getPickupCard();
    } else {
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

  final List<Map<String, dynamic>> _details = [
    {
      'Name': 'Guardian1',
      'Contact': '9999999999',
      'Relation': 'Father',
      'Aadhar No.': '123456789012',
    },
    {
      'Name': 'Guardian2',
      'Contact': '8888888888',
      'Relation': 'Mother',
      'Aadhar No.': '123456789013'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: ListView(
          //padding:const  EdgeInsets.only(top:20),
          children: [
            // Text("Pickup Card", style: titleTextStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pickup Card", style: titleTextStyle),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                        context, const EditPickUpCard()),
                    child: Icon(
                      Icons.edit,
                      size: 30.0,
                      color: ColorConstants.kHeadingTextColor,
                    ),
                  ),
                )
              ],
            ),
            smallSizedBox,
            Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: textButtonTextStyle,
            ),
            divider,
            buildPickupCard(),
            largeSizedBox,
            largeSizedBox,
            largeSizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: CustomElevatedButton(
                onPressed: () {
                  takePicture();
                },
                borderRadius: BorderRadius.circular(20),
                child: Text(
                  Strings.download,
                  style: buttonTextStyle1,
                ),
              ),
            ),
          ],
        ));
  }

  buildPickupCard() {
    return Obx(() => pickupCardController.isLoading == true
        ? Center(
            child: Image.asset(
              "assets/loading.gif",
              height: 425.0,
              width: 425.0,
              fit: BoxFit.fitHeight,
            ),
          )
        : pickupCardController.status == "Pickup card not found"
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no-data.gif"),
                  smallSizedBox,
                  Text(
                    "Pickup card not found",
                    style: TextStyle(color: Colors.purple[800]),
                  )
                ],
              )
            : RepaintBoundary(
                key: genKey,
                child: Card(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              pickupCardController.pickup_card_details.isEmpty
                                  ? ""
                                  : "https://synramtechnology.com/lahs/storage/app/${pickupCardController.pickup_card_details["student_details"][0]["student_photo"]}",
                              height: 60,
                              width: 70,
                              alignment: Alignment.topLeft,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Name:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 30),
                                    Text(
                                      loginController.studentName.value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Class:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 33),
                                    Text(
                                      pickupCardController
                                              .pickup_card_details.isEmpty
                                          ? ""
                                          : pickupCardController
                                                      .pickup_card_details[
                                                  "student_details"][0]
                                              ["class_name"],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Section:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 18),
                                    Text(
                                      pickupCardController
                                              .pickup_card_details.isEmpty
                                          ? ""
                                          : pickupCardController
                                                      .pickup_card_details[
                                                  "student_details"][0]
                                              ["section_name"],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Gender:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      pickupCardController
                                              .pickup_card_details.isEmpty
                                          ? ""
                                          : StringUtils.capitalize(
                                              "${pickupCardController.pickup_card_details["student_details"][0]["student_gender"]}"),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "DOB:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 36),
                                    Text(
                                      pickupCardController
                                              .pickup_card_details.isEmpty
                                          ? ""
                                          : pickupCardController
                                                      .pickup_card_details[
                                                  "student_details"][0]
                                              ["student_dob"],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        smallSizedBox,
                        const Text(
                          "Guardian's Details:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        smallSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Name:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Contact:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            // const SizedBox(width:1),
                            const Text(
                              "Relation:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Aadhar No.:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        smallSizedBox,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              pickupCardController.pickup_card_details.isEmpty
                                  ? 0
                                  : pickupCardController
                                      .pickup_card_details["guardian_details"]
                                      .length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  pickupCardController.pickup_card_details[
                                      "guardian_details"][index]["name"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                // const SizedBox(width:1),
                                Text(
                                  pickupCardController.pickup_card_details[
                                      "guardian_details"][index]["contact"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  pickupCardController.pickup_card_details[
                                      "guardian_details"][index]["relation"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  pickupCardController.pickup_card_details[
                                      "guardian_details"][index]["aadhar_no"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                // const SizedBox(width: 4),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )));
  }

  Future<void> takePicture() async {
    final RenderRepaintBoundary boundary =
        genKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final directory = (await DownloadsPathProvider.downloadsDirectory).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    File imgFile = new File('$directory/photo.png');
    await imgFile.writeAsBytes(pngBytes!);
    print(imgFile.path);
  }
}
