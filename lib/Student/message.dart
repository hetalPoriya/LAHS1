// ignore_for_file: unused_import, sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/compose_message.dart';
import 'package:little_angels/Student/outbox.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_checkbox.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../Controller/messageController.dart';
import '../utils/network_handler.dart';
import 'inbox.dart';

class Message extends StatefulWidget {
  final String? name;

  const Message({
    Key? key,
    this.name,
  }) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');
  var messageController = Get.put(MessageController());
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        messageController.getStuMessages();
      });
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

  final List<Map<String, dynamic>> _events = [
    {'title': 'Monday', 'Description': 'Welcome'},
    {'title': 'Mid Term Exam', 'Description': 'Hi this is testing feeds'},
    {'title': 'Final Exam', 'Description': 'Hi this is testing feeds'},
    {'title': 'Final Exam', 'Description': 'Hi this is testing feeds'},
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        automaticallyImplyLeading: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 10),
          child: Obx(
            () => messageController.msgIsLoading ==true?
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
                "Messages".toUpperCase(),
                style: titleTextStyle,
              ),
              divider,
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      // padding: const  EdgeInsets.only(right:60),
                      tabs: [
                        const Tab(
                          text: "INBOX",
                        ),
                        const Tab(
                          text: "OUTBOX",
                        ),
                      ],
                      indicator: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 220, 241),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      indicatorPadding: const EdgeInsets.only(
                          top: 8, bottom: 10, left: 4, right: 4),
                      labelColor: ColorConstants.kHeadingTextColor,
                      labelStyle: const TextStyle(fontSize: 15),
                      unselectedLabelColor: ColorConstants.kBlackColor,
                    ),
                  ),
                  InkWell(
                    onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                        context, const ComposeMessage()),
                    child: Row(
                      children: const [
                        Icon(Icons.add_circle_outlined,
                            color: ColorConstants.kHeadingTextColor),
                        SizedBox(width: 5),
                        Text("NEW MESSAGE")
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              buildTabBarView(context, _events),
            ],
          ),
        ),
        // const SizedBox(height: 10),
      ),
    ));
  }
}

inboxtoptabs(context) {
  return DefaultTabController(
    length: 2,
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const TabBar(
              isScrollable: true,
              indicatorWeight: 3.0,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    'Unselect All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Select All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 300,
          // ),
          buildInboxTabBarView(context),
        ],
      ),
    ),
  );
}

buildInboxTabBarView(context) {
  var messageController = Get.put(MessageController());
  return Expanded(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Obx(
              () => TabBarView(
            key: ValueKey(DateTime.now().toString()),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              messageController.inbox_message.length==0?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no-message.gif"),
                  smallSizedBox,
                  Text("There are no chats in your inbox", style: TextStyle(color: Colors.blueGrey[100]),)
                ],
              ):ListView.builder(
                  itemCount: messageController.inbox_message.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15.0)),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                      child: ListTile(
                        title: Text(messageController.inbox_message[index].teacherName),
                        leading: SizedBox(
                          width: 60,
                          child: Center(
                            child: Row(
                              children: [
                                CustomCheckBox(
                                    value: false,
                                    onValueChange: (value) {
                                      value = !value;
                                    }),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  AssetImages.drawerMyProfile,
                                  color: Colors.black,
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                        subtitle: Text(messageController.inbox_message[index].messageTitle),
                        trailing: Text(
                          DateFormat('dd MMMM yyyy   \n   hh:mm a')
                              .format(messageController.inbox_message[index].messageReceivedOn),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        onTap: () =>AnimatedNavigation.pushAnimatedNavigation(context,Inbox(id: index, from: "student",)),
                      ),
                    ),
                  )),
              messageController.inbox_message.length==0?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no-message.gif"),
                  smallSizedBox,
                  Text("There are no chats in your inbox", style: TextStyle(color: Colors.blueGrey[100]),)
                ],
              ):ListView.builder(
                itemCount: messageController.inbox_message.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    child: ListTile(
                      title: Text(messageController.inbox_message[index].teacherName),
                      leading: SizedBox(
                        width: 60,
                        child: Center(
                          child: Row(
                            children: [

                              CustomCheckBox(
                                  value: true,
                                  onValueChange: (value) {
                                    value = !value;
                                  }),
                              const SizedBox(width: 5),
                              SvgPicture.asset(AssetImages.drawerMyProfile,
                                color: Colors.black,
                                height: 25,),

                            ],
                          ),
                        ),
                      ),

                      subtitle: Text(messageController.inbox_message[index].messageTitle),
                      trailing: Text(
                        DateFormat('dd MMMM yyyy   \n   hh:mm a')
                            .format(messageController.inbox_message[index].messageReceivedOn),
                        style:const  TextStyle(color: Colors.grey),
                      ),
                      onTap: () =>AnimatedNavigation.pushAnimatedNavigation(context,Inbox(id: index, from: "student",)),
                    ),
                  ),
                ),
              ),
            ],
          )),
    ),
  );
}

outboxtoptabs(context) {
  return DefaultTabController(
    length: 2,
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const TabBar(
              isScrollable: true,
              indicatorWeight: 3.0,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    'Unselect All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Select All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 300,
          // ),
          buildOutboxTabBarView(context),
        ],
      ),
    ),
  );
}

buildOutboxTabBarView(context) {
  var messageController = Get.put(MessageController());
  return Expanded(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Obx(
              () => TabBarView(
            key: ValueKey(DateTime.now().toString()),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              messageController.outbox_message.length==0?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no-message.gif"),
                  smallSizedBox,
                  Text("There are no chats in your outbox", style: TextStyle(color: Colors.blueGrey[100]),)
                ],
              ):ListView.builder(
                  itemCount: messageController.outbox_message.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15.0)),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                      child: ListTile(
                        title: Text(messageController.outbox_message[index].teacherName),
                        leading: SizedBox(
                          width: 60,
                          child: Center(
                            child: Row(
                              children: [
                                CustomCheckBox(
                                    value: false,
                                    onValueChange: (value) {
                                      value = !value;
                                    }),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  AssetImages.drawerMyProfile,
                                  color: Colors.black,
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                        subtitle: Text(messageController.outbox_message[index].messageTitle),
                        trailing: Text(
                          DateFormat('dd MMMM yyyy   \n   hh:mm a')
                              .format(messageController.outbox_message[index].messageSentOn),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        onTap: () =>AnimatedNavigation.pushAnimatedNavigation(context,Outbox(id: index, from: "student",)),
                      ),
                    ),
                  )),
              messageController.outbox_message.length==0?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no-message.gif"),
                  smallSizedBox,
                  Text("There are no chats in your outbox", style: TextStyle(color: Colors.blueGrey[100]),)
                ],
              ):ListView.builder(
                itemCount: messageController.outbox_message.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    child: ListTile(
                      title: Text(messageController.outbox_message[index].teacherName),
                      leading: SizedBox(
                        width: 60,
                        child: Center(
                          child: Row(
                            children: [

                              CustomCheckBox(
                                  value: true,
                                  onValueChange: (value) {
                                    value = !value;
                                  }),
                              const SizedBox(width: 5),
                              SvgPicture.asset(AssetImages.drawerMyProfile,
                                color: Colors.black,
                                height: 25,),

                            ],
                          ),
                        ),
                      ),

                      subtitle: Text(messageController.outbox_message[index].messageTitle),
                      trailing: Text(
                        DateFormat('dd MMMM yyyy   \n   hh:mm a')
                            .format(messageController.outbox_message[index].messageSentOn),
                        style:const  TextStyle(color: Colors.grey),
                      ),
                      onTap: () =>AnimatedNavigation.pushAnimatedNavigation(context,Outbox(id: index, from: "student",)),
                    ),
                  ),
                ),
              ),
            ],
          )),
    ),
  );
}

buildTabBarView(context, _events) {
  return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: TabBarView(
          key: ValueKey(DateTime.now().toString()),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            inboxtoptabs(context),
            outboxtoptabs(context),
            // const Center(
            //   child: Text("2"),
            // ),
          ],
        ),
      ));
}
