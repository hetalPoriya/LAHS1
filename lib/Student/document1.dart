// ignore_for_file: unused_import, avoid_web_libraries_in_flutter

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/document2.dart';
import 'package:little_angels/Student/document_list.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../Controller/documentController.dart';

class Document1 extends StatefulWidget {
  final int monthLength;
  final int yearIndex;
  Document1 ({Key? key, required this.monthLength,required this.yearIndex}) : super(key: key);

  @override
  State<Document1> createState() => _Document1State();
}

class _Document1State extends State<Document1> {
  var documentController = Get.put(DocumentController());
  final List<Map<String, dynamic>> _year = [
    {'title': 'May 18'},
    {
      'title': 'April 22',
    },
    {
      'title': 'March 28',
    },
   
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Document".toUpperCase(),
              style: titleTextStyle,
            ),
            Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            divider,
            largeSizedBox,
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Obx(
                  ()=> documentController.isLoading ==true?
                  Center(
                    child: Image.asset(
                      "assets/loading.gif",
                      height: 425.0,
                      width: 425.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ):ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.monthLength,
                  itemBuilder: (context, index) {
                    var entry = documentController.docdata.entries.elementAt(widget.yearIndex);
                    return GestureDetector(
                      onTap: () => entry.value["month_folder"][index].containsKey("documents")?AnimatedNavigation.pushAnimatedNavigation(
                          context, DocumentList(yearIndex: widget.yearIndex, docLength: entry.value["month_folder"][index]["documents"].length, monthIndex: index,)):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Folder is Empty"),duration: Duration(milliseconds: 700),),
                      ),
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
                                entry.value["month_folder"][index]["folder_name"],
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
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
