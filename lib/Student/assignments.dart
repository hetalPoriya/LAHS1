// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/assignments_inbox.dart';
import 'package:little_angels/Student/events_activity.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Student/todays_work.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/network_handler.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../Controller/assignmentController.dart';

class Assignments extends StatefulWidget {
  final String? name;
  const Assignments({Key? key, this.name}) : super(key: key);

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
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
      assignmentController.getStuAssignment();
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
    return DefaultTabController(
        length: 3,
        child: CustomScaffold(
          automaticallyImplyLeading: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 10),
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
                Text(
                  "My Assignments".toUpperCase(),
                  style: titleTextStyle,
                 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: ()=>AnimatedNavigation.pushAnimatedNavigation(context, TodaysWork(
                        name: "Today's Work",
                      )),
                      child: SvgPicture.asset(
                        AssetImages.calendar,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                divider,
                const TabBar(
                  tabs: [
                    Tab(
                      text: "     Pending \n Assignments",
                    ),
                    Tab(
                      text: "   Submitted \n Assignments",
                    ),
                    Tab(
                      text: "       Past \n Assignments",
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
        )));
  }
}

buildTabBarView(context) {
  var assignmentController = Get.put(AssignmentController());
  return Expanded(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Obx(
      () => TabBarView(
        key: ValueKey(DateTime.now().toString()),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          assignmentController.pending_assignments.length==0?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-data.gif"),
              smallSizedBox,
              Text("There are no pending assignments", style: TextStyle(color: Colors.purple[800]),)
            ],
          ):ListView.builder(
            shrinkWrap: true,
            itemCount: assignmentController.pending_assignments.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: ()=>AnimatedNavigation.pushAnimatedNavigation(context, AssignmentInbox(id: index, name: "pending_assignments",)),
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
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              assignmentController.pending_assignments[index].subjectName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            /*const Text(
                              "Xyz",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )*/
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 45.0,
                          width: 1.0,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              assignmentController.pending_assignments[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy HH:mm')
                                  .format(assignmentController.pending_assignments[index].expireAt),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "Assignment Doc Link",
                              style: TextStyle(color: Colors.blue, fontSize: 12),
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
          assignmentController.submitted_assignments.length==0?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-data.gif"),
              smallSizedBox,
              Text("There are no submitted assignments", style: TextStyle(color: Colors.purple[800]),)
            ],
          ):ListView.builder(
            shrinkWrap: true,
            itemCount: assignmentController.submitted_assignments.length,
            itemBuilder: (context, index) {
              return InkWell(
                 onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                    context, AssignmentInbox(id: index, name: "submitted_assignments",)),
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
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              assignmentController.submitted_assignments[index].subjectName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            /*const Text(
                              "Xyz",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )*/
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 45.0,
                          width: 1.0,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              assignmentController.submitted_assignments[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy HH:mm')
                                  .format(assignmentController.submitted_assignments[index].expireAt),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "Assignment Doc Link",
                              style: TextStyle(color: Colors.blue, fontSize: 12),
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
          assignmentController.past_assignments.length==0?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-data.gif"),
              smallSizedBox,
              Text("There are no past assignments", style: TextStyle(color: Colors.purple[800]),)
            ],
          ):ListView.builder(
            shrinkWrap: true,
            itemCount: assignmentController.past_assignments.length,
            itemBuilder: (context, index) {
              return InkWell(
                 onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                    context, AssignmentInbox(id: index, name: "past_assignments",)),
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
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              assignmentController.past_assignments[index].subjectName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            /*const Text(
                              "Xyz",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )*/
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 45.0,
                          width: 1.0,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              assignmentController.past_assignments[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy HH:mm')
                                  .format(assignmentController.past_assignments[index].expireAt),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "Assignment Doc Link",
                              style: TextStyle(color: Colors.blue, fontSize: 12),
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
      )),
    ),
  );
}
