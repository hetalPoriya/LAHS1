// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/assignments_inbox.dart';
import 'package:little_angels/Student/events_activity.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Teacher/action_assignment.dart';
import 'package:little_angels/Teacher/create_assignment.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../Controller/assignmentController.dart';
import '../utils/network_handler.dart';

class TeacherAssignments extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherAssignments({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherAssignments> createState() => _TeacherAssignmentsState();
}

class _TeacherAssignmentsState extends State<TeacherAssignments> {
  var assignmentController = Get.put(AssignmentController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      assignmentController.getTeacherAssignment();
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
    return SafeArea(
      top: true,
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              leading: IconButton(
                  alignment: Alignment.topLeft,
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
              automaticallyImplyLeading: false,
              toolbarHeight: 160,
              centerTitle: true,
              flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  // bottomRight: Radius.circular(20)
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetImages.assignment1),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              backgroundColor: Color.fromRGBO(55, 61, 99, 1.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  //bottomRight: Radius.circular(40),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Obx(
              () => assignmentController.isLoading ==true?
              Center(
              child: Image.asset(
              "assets/loading.gif",
              height: 425.0,
              width: 425.0,
              fit: BoxFit.fitHeight,
              ),
              ):Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Assignments".toUpperCase(),
                      style: titleTextStyle,
                    ),
                  ),
                  smallSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: textButtonTextStyle,
                      ),
                      // SvgPicture.asset(AssetImages.search, height: 25),
                      ElevatedButton(
                        onPressed: () =>
                            AnimatedNavigation.pushAnimatedNavigation(
                                context, CreateAssignment()),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          primary: Colors.deepPurple,
                        ),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              "Add Assignment",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  divider,
                  const TabBar(
                    tabs: [
                      Tab(
                        text: "     Checked \n Assignments",
                      ),
                      Tab(
                        text: "   Unchecked \n Assignments",
                      ),
                      Tab(
                        text: "       All \n Uploaded \n Assignments",
                      ),
                    ],
                    isScrollable: true,
                    labelColor: ColorConstants.kBlackColor,
                    labelStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    unselectedLabelColor: ColorConstants.kBlackColor,
                  ),
                  const SizedBox(height: 10),
                  buildTabBarView(context),
                ],
              ),
              ),
            ),
          )),
    );
  }
}

buildTabBarView(context) {
  var assignmentController = Get.put(AssignmentController());
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.4,
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Obx(
      () =>TabBarView(
        key: ValueKey(DateTime.now().toString()),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          assignmentController.checked_assignments.length==0?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-data.gif"),
              smallSizedBox,
              Text("There are no pending assignments", style: TextStyle(color: Colors.purple[800]),)
            ],
          ):
          ListView.builder(
            shrinkWrap: true,
            itemCount: assignmentController.checked_assignments.length,
            itemBuilder: (context, index) {
              return InkWell(
                // onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                //     context, AssignmentInbox()),
                child: Card(
                  color: ColorConstants.kGreyColor100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AssetImages.folder,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "${assignmentController.checked_assignments[index].assignmentTitle}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            smallSizedBox,
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.class_,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Class: ${assignmentController.checked_assignments[index].className}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                const SizedBox(width: 20),
                                const Icon(
                                  Icons.punch_clock,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Section: ${assignmentController.checked_assignments[index].sectionName}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                            smallSizedBox,
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Subject: ${assignmentController.checked_assignments[index].subjectName}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                            smallSizedBox,
                            Text(
                              "Assignment Doc Link",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Action",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () =>
                                  AnimatedNavigation.pushAnimatedNavigation(
                                      context, ActionAssignment()),
                              child: const Icon(
                                Icons.remove_red_eye,
                                size: 20,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          assignmentController.unchecked_assignments.length==0?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-data.gif"),
              smallSizedBox,
              Text("There are no pending assignments", style: TextStyle(color: Colors.purple[800]),)
            ],
          ):ListView.builder(
            shrinkWrap: true,
            itemCount: assignmentController.unchecked_assignments.length,
            itemBuilder: (context, index) {
              return InkWell(
                // onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                //     context, AssignmentInbox()),
                child: Card(
                  color: ColorConstants.kGreyColor100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AssetImages.folder,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "${assignmentController.unchecked_assignments[index].assignmentTitle}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            smallSizedBox,
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.class_,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Class: ${assignmentController.unchecked_assignments[index].className}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                const SizedBox(width: 20),
                                const Icon(
                                  Icons.punch_clock,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Section: ${assignmentController.unchecked_assignments[index].sectionName}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                            smallSizedBox,
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Subject: ${assignmentController.unchecked_assignments[index].subjectName}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                            smallSizedBox,
                            Text(
                              "Assignment Doc Link",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Action",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          assignmentController.all_assignments.length==0?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-data.gif"),
              smallSizedBox,
              Text("There are no pending assignments", style: TextStyle(color: Colors.purple[800]),)
            ],
          ):ListView.builder(
            shrinkWrap: true,
            itemCount: assignmentController.all_assignments.length,
            itemBuilder: (context, index) {
              return InkWell(
                // onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                //     context, AssignmentInbox()),
                child: Card(
                  color: ColorConstants.kGreyColor100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AssetImages.folder,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "${assignmentController.all_assignments[index].assignmentTitle}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            smallSizedBox,
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.class_,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Class: ${assignmentController.all_assignments[index].className}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                const SizedBox(width: 20),
                                const Icon(
                                  Icons.punch_clock,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Section: ${assignmentController.all_assignments[index].sectionName}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                            smallSizedBox,
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.pink,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Subject: ${assignmentController.all_assignments[index].subjectName}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                            smallSizedBox,
                            Text(
                              "Assignment Doc Link",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      ),
    ),
  );
}
