import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'custom_page.dart';

class ShowImage extends StatefulWidget {
  final String? url;
  const ShowImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImage();
}

class _ShowImage extends State<ShowImage> {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      titleWidget: const Text(
        "Image",
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),
      ),
      automaticallyImplyLeading: false,
      child:  new FadeInImage(
        image: NetworkImage("${widget.url}"),
        placeholder: AssetImage(
          "assets/loading.gif",
        ),
        imageErrorBuilder:
            (context, error, stackTrace) {
          return Image.asset(
              'assets/images/error.jpg',
              fit: BoxFit.fitWidth);
        },
        fit: BoxFit.fitWidth,
        height: double.infinity,
        width: double.infinity,
        //alignment: Alignment.center,
      ),
    );
  }
}