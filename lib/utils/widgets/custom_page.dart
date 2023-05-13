import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/custom_drawer.dart';

class CustomScaffold extends StatefulWidget {
  final bool? showAppBar, automaticallyImplyLeading;
  final Widget? child;
  final String? bgImage;
  final Widget? leading, titleWidget;
  const CustomScaffold({
    Key? key,
    required this.child,
    this.leading,
    this.titleWidget,
    this.showAppBar = true,
    this.automaticallyImplyLeading = false,
    this.bgImage = AssetImages.mainBackground,
  }) : super(key: key);

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEdgeDragWidth: 0.0,
      appBar: widget.showAppBar!
          ? CustomAppBar(
              scaffoldKey: _scaffoldKey,
              titleWidget: widget.titleWidget,
              automaticallyImplyLeading: widget.automaticallyImplyLeading!,
            )
          : null,
      extendBodyBehindAppBar: true,
      drawer: const CustomDrawer(),
      // extendBody: true,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              widget.bgImage!,
              //width: double.infinity,
              height: MediaQuery.of(context).size.height/4,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: edgeInsets,
            child: widget.child!,
          )
        ],
      ),
    );
  }
}
