// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/messageController.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class Inbox extends StatefulWidget {
  final int? id;
  final String? from;
  const Inbox({Key? key, this.id, this.from}) : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  var messageController = Get.put(MessageController());
  initState(){
    //print(widget.id);
    print(messageController.inbox_message[widget.id!].messageId);
  }
  DateTime todayDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        titleWidget: const Text(
          "Inbox",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(right: 10),
              dense: true,
              isThreeLine: false,
              leading: SvgPicture.asset(
                AssetImages.drawerMyProfile,
                color: Colors.black,
                height: 30,
              ),
              title: Text(
                messageController.inbox_message[widget.id!].messageTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              subtitle: widget.from == "teacher"?
              Text(
                messageController.outbox_message[widget.id!].studentName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ):
              Text(
                messageController.inbox_message[widget.id!].teacherName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              trailing:
                  Text(DateFormat().add_jm().format(messageController.inbox_message[widget.id!].messageReceivedOn).toString()),
            ),
            const Divider(color: Colors.grey),
            Text(
              messageController.inbox_message[widget.id!].messageTitle,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            largeSizedBox,
            
            Text(
              messageController.inbox_message[widget.id!].message,
              style: TextStyle(fontSize: 15),
            ),
            /*largeSizedBox,
            const Text(
              "Greetings!",
              style: TextStyle(fontSize: 15),
            ),
            largeSizedBox,
            largeSizedBox,
            const Text(
                "It was wonderfull to have Adein in class.I wish him all the best for as bright future."),
            largeSizedBox,
            largeSizedBox,
            const Text("Regards"),
            smallSizedBox,
            const Text("Attachment")*/
          ],
        ));
  }
}
