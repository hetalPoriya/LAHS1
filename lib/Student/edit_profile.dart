// ignore_for_file: unused_import, prefer_final_fields

import 'dart:developer';
//import 'dart:js';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/my_profile.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class EditProfile extends StatefulWidget {
  Map<String, dynamic> userData;
  EditProfile({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? selectedValue;
  List<String> items = [
    'Male',
    'Female',
    'Others',
  ];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _parentsnameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();
  TextEditingController _mobilenumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  DateTime todayDate = DateTime.now();

  @override
  void initState() {
    setState(() {
      _nameController.text = widget.userData['name'];
      _classController.text = widget.userData['class'];
      _parentsnameController.text = widget.userData['pname'];
      _emailController.text = widget.userData['email'];
      _sectionController.text = widget.userData['section'];
      _dobController.text = widget.userData['dob'];
      _mobilenumberController.text = widget.userData['mobile'];
      selectedValue = items.firstWhere((element) => element == widget.userData['gender']) ;
    });
    super.initState();
  }

  File? image;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
    Navigator.of(context).pop();
  }

  getImageData(image) {
    if (image == null) {
      return  NetworkImage(widget.userData['profile_image'] ?? "https://picsum.photos/seed/picsum/200/300/");
    }
    return FileImage(image);
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
                const EdgeInsets.only(top: 18, bottom: 20, left: 15, right: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Edit Profile",
                style: titleTextStyle,
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
                            fit: BoxFit.cover, image: getImageData(image)),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 100,
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "Choose Profile photo",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () => pickImage(
                                                      ImageSource.camera),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.camera,
                                                    color: Colors.black,
                                                  ),
                                                  label: const Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () => pickImage(
                                                      ImageSource.gallery),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.image,
                                                    color: Colors.black,
                                                  ),
                                                  label: const Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ])
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Name",
                  //textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
              ),
              Container(
                child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      hintText: ("Student Name"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
              // const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Class",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _classController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("Enter class"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
              //  const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      'Select Gender',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Parents Name",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _parentsnameController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("Parents"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "E-mail Address",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("Email"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),

              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Section",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _sectionController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("Section"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Date Of Birth",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("DOB"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Father Contact No.",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _mobilenumberController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("Mobile No."),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),

              const SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          child: const Text(
                            "Update",
                            style: TextStyle(fontSize: 12),
                          ),
                          onPressed: () {
                            log(_emailController.text);
                            log(_nameController.text);
                            log(_mobilenumberController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: const Color.fromRGBO(105, 80, 255, 1.0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: ()=>AnimatedNavigation.pushReplacementAnimatedNavigation(context,const  MyProfile()),
                        
                      
                        child: const Text(
                          "Cancel",
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
              ),
            ]),
          ),
        ));
  }
}

Widget bottomSheet() {
  return Container(
    height: 100.0,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(
      children: <Widget>[
        const Text(
          "Choose Profile photo",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera),
            label: const Text("Camera"),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.image),
            label: const Text("Gallery"),
          ),
        ])
      ],
    ),
  );
}
