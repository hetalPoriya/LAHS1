import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:little_angels/utils/images.dart';

class CustomCheckBox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool>? onValueChange;
  final bool? tristate;

  const CustomCheckBox({
    Key? key,
    this.value,
    this.onValueChange,
    this.tristate = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  void didUpdateWidget(CustomCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.onValueChange?.call(!value!);
          if (!widget.tristate!) {
            value = !value!;
          } else {
            value = value == null
                ? true
                : value! == true
                    ? false
                    : null;
          }
        });
      },
      child: SvgPicture.asset(
        widget.tristate! && value == null
            ? AssetImages.checkBox
            : value!
                ? AssetImages.checkBox
                : AssetImages.unCheckBox,
        height: 20,
        width: 20,
      ),
    );
  }
}
