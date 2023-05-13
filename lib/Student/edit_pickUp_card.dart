// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/loginController.dart';
import 'package:little_angels/Controller/pickupCardController.dart';
import 'package:little_angels/Student/edit_profile.dart';
import 'package:little_angels/Student/home_page.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../Controller/stuProfileController.dart';
import '../utils/network_handler.dart';

class EditPickUpCard extends StatefulWidget {
  const EditPickUpCard({
    Key? key,
  }) : super(key: key);

  @override
  State<EditPickUpCard> createState() => _EditPickUpCardState();
}

class _EditPickUpCardState extends State<EditPickUpCard> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController guardianNameController = TextEditingController();

  TextEditingController _classController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  // TextEditingController _guardianMobilenumber1Controller =
  //     TextEditingController();
  // TextEditingController _guardianMobilenumber2Controller =
  //     TextEditingController();
  // TextEditingController _guardianName1Controller = TextEditingController();
  // TextEditingController _guardianName2Controller = TextEditingController();
  // TextEditingController _guardianRelation1Controller = TextEditingController();
  // TextEditingController _guardianRelation2Controller = TextEditingController();
  // TextEditingController _guardianAadharNo1Controller = TextEditingController();
  // TextEditingController _guardianAadharNo2Controller = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  // bool showPassword = false;
  DateTime todayDate = DateTime.now();
  int selectedIndex = 0;
  var loginController = Get.put(LoginController());

  var pickupCardController = Get.put(PickupCardController());
  NetworkHandler nr = NetworkHandler();
  final GlobalKey genKey = GlobalKey();

  // List<Map<String, dynamic>> profileList = [
  //   {
  //     'name': 'User 1',
  //     'class': 'I',
  //     'gender': 'Male',
  //     'section': 'A',
  //     'pname': 'Parent 1',
  //     'email': 'abc@gmail.com',
  //     'dob': '20-03-2008',
  //     'mobile': '9876543211',
  //     'profile_image':
  //         'https://cdn3.iconfinder.com/data/icons/vector-icons-6/96/256-512.png',
  //   },
  //   {
  //     'name': 'User 2',
  //     'class': 'II',
  //     'gender': 'Female',
  //     'section': 'A',
  //     'pname': 'Parent 2',
  //     'email': 'abc@gmail.com',
  //     'dob': '20-03-2008',
  //     'mobile': '9876543211',
  //     'profile_image':
  //         'https://as1.ftcdn.net/v2/jpg/02/32/71/62/1000_F_232716200_xTsnomMS5djsC6m9cDNQmEKtPgt11Xjo.jpg',
  //   }
  // ];
  // NetworkHandler nr = NetworkHandler();
  // var studentProfileController = Get.put(stuProfileController());
  @override
  void initState() {
    // TODO: implement initState
    //_init();
    super.initState();
  }

  // List<TextEditingController> _textEditing = [];
  // _init() async {
  //   bool isConnected = await nr.checkConnectivity();
  //   print(isConnected);
  //   if (isConnected) {
  //     await pickupCardController.getPickupCard();
  //     _nameController.text = loginController.studentName.value;
  //     _classController.text = pickupCardController.pickup_card_details.isEmpty
  //         ? ""
  //         : pickupCardController.pickup_card_details["student_details"][0]
  //             ["class_name"];
  //     _sectionController.text = pickupCardController.pickup_card_details.isEmpty
  //         ? ""
  //         : pickupCardController.pickup_card_details["student_details"][0]
  //             ["section_name"];
  //     _genderController.text = pickupCardController.pickup_card_details.isEmpty
  //         ? ""
  //         : StringUtils.capitalize(
  //             "${pickupCardController.pickup_card_details["student_details"][0]["student_gender"]}");
  //     _dobController.text = pickupCardController.pickup_card_details.isEmpty
  //         ? ""
  //         : pickupCardController.pickup_card_details["student_details"][0]
  //             ["student_dob"];
  //     for (int i = 0;
  //         i <
  //             pickupCardController
  //                 .pickup_card_details["guardian_details"].length;
  //         i++) {
  //       TextEditingController textEditingController = TextEditingController();
  //       _textEditing.add(guardianNameController);
  //       _guardianName${i}Controller = TextEditingController();
  //       _guardianName1Controller.text = pickupCardController
  //           .pickup_card_details["guardian_details"][i]["name"];
  //       _guardianMobilenumber1Controller.text = pickupCardController
  //           .pickup_card_details["guardian_details"][i]["contact"];
  //       _guardianRelation1Controller.text = pickupCardController
  //           .pickup_card_details["guardian_details"][i]["relation"];
  //       _guardianAadharNo1Controller.text = pickupCardController
  //           .pickup_card_details["guardian_details"][i]["aadhar_no"];
  //       _guardianName2Controller.text = pickupCardController
  //           .pickup_card_details["guardian_details"][i]["name"];
  //       _guardianMobilenumber2Controller.text = pickupCardController
  //           .pickup_card_details["guardian_details"][i]["contact"];
  //       _guardianRelation2Controller.text = pickupCardController
  //           .pickup_card_details["guardian_details"][i]["relation"];
  //       _guardianAadharNo2Controller.text = pickupCardController
  //           .pickup_card_details["guardian_details"][i]["aadhar_no"];
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       duration: Duration(days: 1),
  //       behavior: SnackBarBehavior.floating,
  //       content: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(
  //             Icons.signal_wifi_off,
  //             color: Colors.white,
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.only(
  //                 left: 16.0,
  //               ),
  //               child: Text(
  //                 'No internet available',
  //                 textAlign: TextAlign.start,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       action: SnackBarAction(
  //           textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
  //       backgroundColor: Colors.grey,
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding:
              const EdgeInsets.only(top: 18, bottom: 40, left: 15, right: 15),
          child: Obx(() => pickupCardController.isLoading == true
                  ? Center(
                      child: Image.asset(
                        "assets/loading.gif",
                        height: 425.0,
                        width: 425.0,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container()
              // : Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               "PickUp card",
              //               style: titleTextStyle,
              //             ),
              //             const Spacer(),
              //           ],
              //         ),
              //         divider,
              //         largeSizedBox,
              //         editProfileTextFormFieldWidget(
              //             hintText: loginController.studentName.value,
              //             textInputType: TextInputType.text,
              //             textEditingController: _nameController,
              //             lableText: 'Name'),
              //         smallSizedBox,
              //         editProfileTextFormFieldWidget(
              //             hintText: _classController.text,
              //             lableText: 'Class',
              //             textEditingController: _classController),
              //         smallSizedBox,
              //         editProfileTextFormFieldWidget(
              //           hintText: _sectionController.text,
              //           lableText: 'Section',
              //           textEditingController: _sectionController,
              //         ),
              //
              //         smallSizedBox,
              //         editProfileTextFormFieldWidget(
              //           hintText: _genderController.text,
              //           lableText: 'Gender',
              //           textEditingController: _genderController,
              //         ),
              //         smallSizedBox,
              //         editProfileTextFormFieldWidget(
              //           hintText: _dobController.text,
              //           lableText: 'DOB',
              //           textEditingController: _dobController,
              //         ),
              //         smallSizedBox,
              //         const Text(
              //           "Guardian's Details:",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, color: Colors.black),
              //         ),
              //         smallSizedBox,
              //         smallSizedBox,
              //
              //         editProfileTextFormFieldWidget(
              //           hintText: _guardianName1Controller.text,
              //           lableText: 'Name',
              //           textEditingController: _guardianName1Controller,
              //         ),
              //         smallSizedBox,
              //         editProfileTextFormFieldWidget(
              //           hintText: _guardianMobilenumber1Controller.text,
              //           lableText: 'Contact',
              //           textEditingController:
              //               _guardianMobilenumber1Controller,
              //         ),
              //         smallSizedBox,
              //         editProfileTextFormFieldWidget(
              //             hintText: _guardianRelation1Controller.text,
              //             lableText: 'Relation',
              //             textEditingController:
              //                 _guardianRelation1Controller),
              //         smallSizedBox,
              //         editProfileTextFormFieldWidget(
              //           hintText: _guardianAadharNo1Controller.text,
              //           lableText: 'Adhar No',
              //           textEditingController: _guardianAadharNo1Controller,
              //         ),
              //         // Center(
              //         //   child: Stack(
              //         //     children: [
              //         //       Container(
              //         //         width: 130,
              //         //         height: 130,
              //         //         decoration: BoxDecoration(
              //         //             border: Border.all(
              //         //                 width: 4,
              //         //                 color: Theme.of(context)
              //         //                     .scaffoldBackgroundColor),
              //         //             boxShadow: [
              //         //               BoxShadow(
              //         //                   spreadRadius: 2,
              //         //                   blurRadius: 10,
              //         //                   color: Colors.black.withOpacity(0.1),
              //         //                   offset: const Offset(0, 10))
              //         //             ],
              //         //             shape: BoxShape.circle,
              //         //             image: DecorationImage(
              //         //                 fit: BoxFit.cover,
              //         //                 image: NetworkImage(
              //         //                     profileList[selectedIndex]
              //         //                         ['profile_image']))),
              //         //       ),
              //         //     ],
              //         //   ),
              //         // ),
              //         largeSizedBox,
              //
              //         smallSizedBox,
              //       ]),
              ),
        )));
  }

  // Widget editProfileTextFormFieldWidget(
  //         {String? hintText,
  //         TextEditingController? textEditingController,
  //         bool? obscureText,
  //         TextInputType? textInputType,
  //         TextInputAction? textInputAction,
  //         String? Function(String?)? validator,
  //         double? radius,
  //         Widget? suffixWidget,
  //         bool? readOnly,
  //         String? lableText}) =>
  //     TextFormField(
  //         readOnly: readOnly ?? false,
  //         validator: validator,
  //         obscureText: obscureText ?? false,
  //         keyboardType: textInputType,
  //         textInputAction: textInputAction ?? TextInputAction.next,
  //         controller: textEditingController,
  //         decoration: InputDecoration(
  //           contentPadding: EdgeInsets.all(6),
  //           filled: true,
  //           fillColor: Colors.grey.shade200,
  //           hintText: hintText,
  //           suffix: suffixWidget,
  //           hintStyle: TextStyle(
  //             color: Colors.black,
  //             fontSize: 18,
  //           ),
  //           labelText: lableText,
  //           labelStyle: TextStyle(
  //             color: Colors.black,
  //             fontSize: 18,
  //           ),
  //           border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(radius ?? 12),
  //               borderSide:
  //                   BorderSide(color: ColorConstants.kPurpleCardLightColor)),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(radius ?? 12),
  //               borderSide:
  //                   BorderSide(color: ColorConstants.kPurpleCardLightColor)),
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(radius ?? 12),
  //               borderSide:
  //                   BorderSide(color: ColorConstants.kPurpleCardLightColor)),
  //         ));
}
