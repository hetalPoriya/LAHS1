// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';

class ChapterWiseList extends StatefulWidget {
  const ChapterWiseList({Key? key}) : super(key: key);

  @override
  State<ChapterWiseList> createState() => _ChapterWiseListState();
}

class _ChapterWiseListState extends State<ChapterWiseList>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = const <Tab>[
    Tab(text: Strings.videos),
    Tab(text: Strings.documents),
  ];

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  nameText() => Row(
        children: [
          Text("Maths",
              style: titleTextStyle.copyWith(color: const Color(0xFF536DFE))),
          Text(
            ' (Chapter 1)',
            style: textButtonTextStyle,
          )
        ],
      );

  tabbarWidget() => DefaultTabController(
        length: tabs.length,
        child: SizedBox(
          height: 40.0,
          child: TabBar(
            isScrollable: true,
            controller: tabController,
            indicatorWeight: 0.0,
            onTap: (int index) {},
            tabs: tabs,
            labelColor: ColorConstants.kWhiteColor,
            labelStyle: TextStyle(
              fontWeight: kFontWeight900,
            ),
            unselectedLabelColor: ColorConstants.kBlackColor54,
            unselectedLabelStyle: TextStyle(
              fontWeight: kFontWeight900,
            ),
            indicator: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFFA364AE)]),
                borderRadius: BorderRadius.circular(6.0)),
          ),
        ),
      );

  tabbarViewWidget() {
    return Expanded(
      child: Container(
        child: TabBarView(controller: tabController, children: [
          GridView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              itemCount: 10,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.0,
                  mainAxisSpacing: 18.0,
                  childAspectRatio: 1),
              itemBuilder: ((context, index) {
                return Material(
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                                image: DecorationImage(
                                    image: AssetImage(AssetImages.activity2),
                                    fit: BoxFit.fill)),
                          ),
                          flex: 2),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rational number',
                              style:
                                  textButtonTextStyle.copyWith(fontSize: 12.0),
                            )),
                      ),
                    ]),
                  ),
                );
              })),
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: 60,
                padding: EdgeInsets.zero,
                //shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ChapterWiseList()))),
                    child: Column(
                      children: [
                        Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                              height: 80.0,
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 12.0, right: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  smallerSizedBox,
                                  Flexible(
                                    child: Text('Equations',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 18.0)),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Equations and geometrical calculations',
                                      style: TextStyle(
                                          fontSize: 9.0, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 90.0,
                                      height: 18.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorConstants
                                                  .kPurpleCardLightColor),
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.download,
                                            size: 12.0,
                                            color: ColorConstants
                                                .kPurpleCardLightColor,
                                          ),
                                          Text(
                                            'Download pdf',
                                            style: TextStyle(
                                              fontSize: 8.0,
                                              color: ColorConstants
                                                  .kPurpleCardLightColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  smallerSizedBox,
                                ],
                              )),
                        ),
                        smallSizedBox,
                        smallSizedBox
                      ],
                    ),
                  );
                })),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        customSizedBox(100.0),
        nameText(),
        largerSizedBox,
        tabbarWidget(),
        smallSizedBox,
        tabbarViewWidget(),
      ],
    ));
  }
}
