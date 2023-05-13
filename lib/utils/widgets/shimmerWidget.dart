import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../colors.dart';

class ShimmerWidget extends StatelessWidget{
  final double width;
  final double height;

  const ShimmerWidget.rectangular({
    required this.width,
    required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          width: width,
          height: height,
          color: Colors.grey,
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!);
  }

}