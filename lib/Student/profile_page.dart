import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class StudentProfile extends StatefulWidget {
  final String? id;
  final String? name;
  const StudentProfile({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final List<Map<String, dynamic>> _data = [
    {
      'title': "My Assignment",
      'icon': AssetImages.myAssignment,
    },
    {
      'title': "My Attendance",
      'icon': AssetImages.myAttendance,
    },
    {
      'title': "My Report Card",
      'icon': AssetImages.myReportCard,
    },
    {
      'title': "Notice Board",
      'icon': AssetImages.noticeBoard,
    },
    {
      'title': "Pick Up Card",
      'icon': AssetImages.pickupCard,
    },
    {
      'title': "Logout",
      'icon': AssetImages.logout,
    },
  ];

  welcomeText() => Text("User", style: greetingTextStyle);

  nameText() => Text(Strings.profile.toUpperCase(), style: titleTextStyle);

  greetingText() => Text("user@gmail.com",
      style: subtitleTextStyle.copyWith(color: ColorConstants.kBlackColor));

  profileImgWidget() => const Expanded(
        flex: 1,
        child: CircleAvatar(
          radius: 45.0,
          backgroundImage: AssetImage(AssetImages.teacherProfile),
          backgroundColor: Colors.orange,
        ),
      );

  listTileWidget() => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _data.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Column(
                children: [
                  ListTile(
                      leading: Image.asset(_data[index]['icon'],
                          width: 35.0, height: 35.0),
                      title: Text(_data[index]['title'].toString(),
                          style: greetingTextStyle.copyWith(
                              color: ColorConstants.kGreyColor600,
                              fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => log(_data[index]['title'].toString())),
                  mediumSizedBox
                ],
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSizedBox(100.0),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  welcomeText(),
                  smallerSizedBox,
                  nameText(),
                  smallSizedBox,
                  greetingText(),
                ],
              ),
            ),
            profileImgWidget()
          ],
        ),
        mediumSizedBox,
        divider,
        smallSizedBox,
        listTileWidget(),
        divider,
      ],
    )));
  }
}
