// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/assignmentController.dart';
import 'package:little_angels/Student/photo_grid.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Student/submit_assignment.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/show_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/animated_navigation.dart';
import '../utils/widgets/video_player.dart';
import '../utils/widgets/youtube_video_player.dart';

class AssignmentInbox extends StatefulWidget {
  final int? id;
  final String? name;
  const AssignmentInbox({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<AssignmentInbox> createState() => _InboxState();
}

class _InboxState extends State<AssignmentInbox> {
  DateTime todayDate = DateTime.now();
  var assignmentController = Get.put(AssignmentController());
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        titleWidget: const Text(
          "Assignment",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        child: widget.name == "pending_assignments" ? ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [
           
            const Divider(color: Colors.grey),
            largerSizedBox,
            Text(
              assignmentController.pending_assignments[widget.id!].title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            smallerSizedBox,
            Text(
                "Subject: "+assignmentController.pending_assignments[widget.id!].subjectName,
              style: TextStyle(fontSize: 15),
            ),
            smallerSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Class: "+assignmentController.pending_assignments[widget.id!].className,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(width: 5,),
                Text(
                  assignmentController.pending_assignments[widget.id!].sectionName,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            smallerSizedBox,
            Text(
              "Last Day To Submit: "+
                  DateFormat('dd/MM/yyyy')
                      .format(assignmentController.pending_assignments[widget.id!].expireAt),
              style: TextStyle(fontSize: 15),
            ),
            largeSizedBox,
            largeSizedBox,
            Text(
              assignmentController.pending_assignments[widget.id!].description,),
            smallerSizedBox,
            assignmentController.pending_assignments[widget.id!].link != null?
                new InkWell(
                    child: new Text('${assignmentController.pending_assignments[widget.id!].link}', style: TextStyle(color: Colors.blue),),
                    onTap: () async{
                      if (await canLaunch(assignmentController.pending_assignments[widget.id!].link)){
                      await launch(assignmentController.pending_assignments[widget.id!].link);
                      } else {
                      // can't launch url
                      }
                    }
                )
                :Wrap(),
            largeSizedBox,
            const Text("Attachment"),
            largeSizedBox,
            GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                //mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 16 / 9,
              children: <Widget>[
                assignmentController.pending_assignments[widget.id!].image == null? Wrap():
                assignmentController.pending_assignments[widget.id!].image == ""? Wrap():
                InkWell(
                  onTap: () {
                    AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      ShowImage(
                          url: "https://synramtechnology.com/lahs/storage/app/"+assignmentController.pending_assignments[widget.id!].image),
                    );
                  },
                  child:ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    AssetImages.english,
                    fit: BoxFit.fill,
                  ),
                ),
                ),
                assignmentController.pending_assignments[widget.id!].video == null? Wrap():
                assignmentController.pending_assignments[widget.id!].video == ""? Wrap():
                InkWell(
                  onTap: () {
                    AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      VideoPlayer(
                          url: assignmentController.pending_assignments[widget.id!].video,
                      ),
                    );
                  },
                  child:
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            AssetImages.english,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Image.asset(
                          AssetImages.videoIcon,
                        ),
                      ],
                    ),
                ),
              ],
            ),
            largerSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                     ElevatedButton(
                  onPressed: () {
                    AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      SubmitAssignment(id: widget.id,)
                    );
                  },
                  child: const Text(
                    "Submit Assignment",
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    primary: const Color.fromRGBO(105, 80, 255, 1.0),
                  ),
                ),
              ],
            )
          ],
        ):
        widget.name == "submitted_assignments"?
        ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [

            const Divider(color: Colors.grey),
            largerSizedBox,
            Text(
              assignmentController.submitted_assignments[widget.id!].title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            smallerSizedBox,
            Text(
              "Subject: "+assignmentController.submitted_assignments[widget.id!].subjectName,
              style: TextStyle(fontSize: 15),
            ),
            smallerSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Class: "+assignmentController.submitted_assignments[widget.id!].className,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(width: 5,),
                Text(
                  assignmentController.submitted_assignments[widget.id!].sectionName,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            largeSizedBox,
            largeSizedBox,
            Text(
              assignmentController.submitted_assignments[widget.id!].description,),
            smallerSizedBox,
            assignmentController.submitted_assignments[widget.id!].link != null?
            new InkWell(
                child: new Text('${assignmentController.submitted_assignments[widget.id!].link}', style: TextStyle(color: Colors.blue),),
                onTap: () async{
                  if (await canLaunch(assignmentController.submitted_assignments[widget.id!].link)){
                    await launch(assignmentController.submitted_assignments[widget.id!].link);
                  } else {
                    // can't launch url
                  }
                }
            )
                :Wrap(),
            largeSizedBox,
            const Text("Attachment"),
            largeSizedBox,
            GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              //mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 16 / 9,
              children: <Widget>[
                assignmentController.submitted_assignments[widget.id!].image == ""?
                    Wrap():
                assignmentController.submitted_assignments[widget.id!].image == null?
                    Wrap():
                InkWell(
                  onTap: () {
                    AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      ShowImage(
                          url: "https://synramtechnology.com/lahs/storage/app/"+assignmentController.submitted_assignments[widget.id!].image),
                    );
                  },
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      AssetImages.english,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                assignmentController.submitted_assignments[widget.id!].video == null?Wrap():
                assignmentController.submitted_assignments[widget.id!].video == ""?Wrap():
                InkWell(
                  onTap: () {
                    AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      VideoPlayer(
                          url: assignmentController.submitted_assignments[widget.id!].video,
                      ),
                    );
                  },
                  child:
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          AssetImages.english,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Image.asset(
                        AssetImages.videoIcon,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            largerSizedBox,
            const Divider(color: Colors.grey),
            smallerSizedBox,
            Text(
              "Assignment Submitted",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            smallerSizedBox,
            Text(
              "Date Submited: "+DateFormat('dd/MM/yyyy')
                  .format(assignmentController.submitted_assignments[widget.id!].submitDateTime),
            ),
            smallerSizedBox,
            assignmentController.submitted_assignments[widget.id!].rejectStatus == 1?
                Text("Assignment rejected"):
            assignmentController.submitted_assignments[widget.id!].teacherCheckStatus == 1?
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Marks: ${assignmentController.submitted_assignments[widget.id!].assignmentMark}"),
                    smallerSizedBox,
                    Text("Feedback: ${assignmentController.submitted_assignments[widget.id!].feedback}"),
                  ],
                ):
                Text("Evalution in progress"),
            mediumSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      PhotoGrid(
                          id:"View Submisssion",
                          url: assignmentController.submitted_assignments[widget.id!].assignmentDocs),
                    );
                  },
                  child: Text(
                    "View Submission",
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    primary: const Color.fromRGBO(105, 80, 255, 1.0),
                  ),
                ),
              ],
            )
          ],
        ):
        ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [

            const Divider(color: Colors.grey),
            largerSizedBox,
            Text(
              assignmentController.past_assignments[widget.id!].title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            smallerSizedBox,
            Text(
              "Subject: "+assignmentController.past_assignments[widget.id!].subjectName,
              style: TextStyle(fontSize: 15),
            ),
            smallerSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Class: "+assignmentController.past_assignments[widget.id!].className,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(width: 5,),
                Text(
                  assignmentController.past_assignments[widget.id!].sectionName,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            largeSizedBox,
            largeSizedBox,
            Text(
              assignmentController.past_assignments[widget.id!].description,),
            smallerSizedBox,
            assignmentController.past_assignments[widget.id!].link != null?
            new InkWell(
                child: new Text('${assignmentController.past_assignments[widget.id!].link}', style: TextStyle(color: Colors.blue),),
                onTap: () async{
                  if (await canLaunch(assignmentController.past_assignments[widget.id!].link)){
                    await launch(assignmentController.past_assignments[widget.id!].link);
                  } else {
                    // can't launch url
                  }
                }
            )
                :Wrap(),
            largeSizedBox,
            const Text("Attachment"),
            largeSizedBox,
            GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              //mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 16 / 9,
              children: <Widget>[
                assignmentController.past_assignments[widget.id!].image == null? Wrap():
                assignmentController.past_assignments[widget.id!].image == ""? Wrap():
                InkWell(
                  onTap: () {
                    AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      ShowImage(
                          url: "https://synramtechnology.com/lahs/storage/app/"+assignmentController.past_assignments[widget.id!].image),
                    );
                  },
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      AssetImages.english,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                assignmentController.past_assignments[widget.id!].video == null?
                Wrap():
                assignmentController.past_assignments[widget.id!].video == ""?
                Wrap():
                InkWell(
                  onTap: () {
                    AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      VideoPlayer(
                          url: assignmentController.past_assignments[widget.id!].video,
                      ),
                    );
                  },
                  child:
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          AssetImages.english,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Image.asset(
                        AssetImages.videoIcon,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            largerSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Submit Assignment",
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    primary: const Color.fromRGBO(217, 212, 248, 1.0),
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}
