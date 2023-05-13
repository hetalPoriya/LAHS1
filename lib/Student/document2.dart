// ignore_for_file: unused_import, avoid_web_libraries_in_flutter

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/document_list.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class Document2 extends StatefulWidget {
  const Document2({Key? key}) : super(key: key);

  @override
  State<Document2> createState() => _Document2State();
}

class _Document2State extends State<Document2> {
  final List<Map<String, dynamic>> _year = [
    {'title': 'Week 1'},
    {
      'title': 'Week 2',
    },
    {
      'title': 'Week 3',
    },
    {
      'title': 'Week 4',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Document".toUpperCase(),
              style: titleTextStyle,
            ),
            Text(
              DateFormat('dd-MM-yyyy').format(DateTime.now()),
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            divider,
            largeSizedBox,
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.30,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _year.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                          context, DocumentList(yearIndex: 1,docLength: 2, monthIndex: 3,)),
                      child: Card(
                        color: ColorConstants.kGreyColor100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssetImages.folder,
                                height: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _year[index]['title'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
