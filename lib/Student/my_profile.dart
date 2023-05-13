// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/loginController.dart';
import 'package:little_angels/Student/edit_profile.dart';
import 'package:little_angels/Student/home_page.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../Controller/stuProfileController.dart';
import '../utils/network_handler.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    Key? key,
  }) : super(key: key);
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _parentsnameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();
  TextEditingController _mobilenumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  // bool showPassword = false;
  DateTime todayDate = DateTime.now();
  int selectedIndex = 0;
  var loginController = Get.put(LoginController());

  List<Map<String, dynamic>> profileList = [
    {
      'name': 'User 1',
      'class': 'I',
      'gender': 'Male',
      'section': 'A',
      'pname': 'Parent 1',
      'email': 'abc@gmail.com',
      'dob': '20-03-2008',
      'mobile': '9876543211',
      'profile_image': 'https://cdn3.iconfinder.com/data/icons/vector-icons-6/96/256-512.png',
    },
    {
      'name': 'User 2',
      'class': 'II',
      'gender': 'Female',
      'section': 'A',
      'pname': 'Parent 2',
      'email': 'abc@gmail.com',
      'dob': '20-03-2008',
      'mobile': '9876543211',
      'profile_image':'https://as1.ftcdn.net/v2/jpg/02/32/71/62/1000_F_232716200_xTsnomMS5djsC6m9cDNQmEKtPgt11Xjo.jpg',
    }
  ];
  NetworkHandler nr = NetworkHandler();
  var studentProfileController = Get.put(stuProfileController());
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
      await studentProfileController.getStuProfile();
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
    return Scaffold(
        appBar: CustomAppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 18, bottom: 40, left: 15, right: 15),
            child:
              Obx(
              () => studentProfileController.isLoading ==true?
                Center(
                  child: Image.asset(
                  "assets/loading.gif",
                  height: 425.0,
                  width: 425.0,
                  fit: BoxFit.fitHeight,
                ),
              ):Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Profile",
                    style: titleTextStyle,
                  ),
                  const Spacer(),
                ],
              ),
              divider,
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(profileList[selectedIndex]
                                  ['profile_image']))),
                    ),

                   
                  ],
                ),
              ),
              largeSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    studentProfileController.student_details.length>0?studentProfileController.student_details[0].studentName:"",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Divider(),
              smallSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Class",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    studentProfileController.student_details.length>0?studentProfileController.student_details[0].studentDetailClass:"",
                    style:const  TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Divider(),
              smallSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gender",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    studentProfileController.student_details.length>0?studentProfileController.student_details[0].gender:"",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Divider(),
              smallSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Parents Name",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    studentProfileController.student_details.length>0?studentProfileController.student_details[0].parentsName:"",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Divider(),
              smallSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "E-mail Address",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                    ),
                  ),
                 Text(
                    profileList[selectedIndex]['email'],
                    style:const  TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Divider(),
              smallSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Section",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                    ),
                  ),
                 Text(
                   studentProfileController.student_details.length>0?studentProfileController.student_details[0].sectionName:"",
                    style:const  TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Divider(),
              smallSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DOB",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    studentProfileController.student_details.length>0?DateFormat('dd-MM-yyyy').format(studentProfileController.student_details[0].dob):"",
                    style:const  TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Divider(),
              smallSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Father Contact No.",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    studentProfileController.student_details.length>0?studentProfileController.student_details[0].fatherContactNo:"",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Divider(),
              smallSizedBox,
            ]),
          ),
        )));
  }
  switchProfileModel(){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Obx(() => loginController.isLoading == true?
          Center(
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
          ):Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: InkWell(
              onTap: () => setState(() {
            switchProfileModel();
          }),
          child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(30),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),

          image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
          "https://cdn3.iconfinder.com/data/icons/vector-icons-6/96/256-512.png",
          ),
          ),
          ),
          ),
          ),
                title: new Text(loginController.studentName.value, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              for(var i=0; i<loginController.siblingDetails.length; i++)
                Column(
                  children: [
                    ListTile(
                      leading: InkWell(
                        onTap: () => setState(() {
                          switchProfileModel();
                        }),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(30),
                            shape: BoxShape.circle,

                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://cdn3.iconfinder.com/data/icons/vector-icons-6/96/256-512.png",
                              ),
                            ),
                          ),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(50),
                          //   child: Image.network(
                          //     profileList[index]['profile_image'],
                          //     height: 30,
                          //     width: 30,
                          //     // fit: BoxFit.cover,
                          //   ),
                          // ),
                        ),
                      ),
                      title: new Text(loginController.siblingDetails[i][0].studentName, style: TextStyle(fontWeight: FontWeight.w500),),
                      onTap: () async {
                        bool isConnected = await nr.checkConnectivity();
                        print(isConnected);
                        if (isConnected) {
                          await loginController.switchProfile(loginController.siblingDetails[i][0].siblingId);
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
                    ),

                  ],
                )
            ],
          ));
        });
  }
}
