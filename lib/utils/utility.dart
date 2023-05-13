import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/images.dart';

const int _color = 0xFFFFFFFF;
MaterialColor kPrimaryColor = const MaterialColor(
  _color,
  <int, Color>{
    50: Color(_color),
    100: Color(_color),
    200: Color(_color),
    300: Color(_color),
    400: Color(_color),
    500: Color(_color),
    600: Color(_color),
    700: Color(_color),
    800: Color(_color),
    900: Color(_color),
  },
);

SizedBox smallerSizedBox = const SizedBox(
  height: 5.0,
);
SizedBox smallSizedBox = const SizedBox(
  height: 10.0,
);
SizedBox mediumSizedBox = const SizedBox(
  height: 15.0,
);
SizedBox largeSizedBox = const SizedBox(
  height: 20.0,
);
SizedBox largerSizedBox = const SizedBox(
  height: 40.0,
);

FontWeight kFontWeight900 = FontWeight.w900;
FontWeight kFontWeight400 = FontWeight.w400;
FontWeight kFontWeightBold = FontWeight.bold;

SizedBox customSizedBox(double? height) => SizedBox(
      height: height,
    );

SizedBox customWidthSizedBox(double? width) => SizedBox(
      width: width,
    );

Divider divider = const Divider(
  color: Colors.black87,
);

BorderRadius containeBorderRadius =
    const BorderRadius.all(Radius.circular(10.0));

BorderRadius cardBorderRadius = BorderRadius.circular(10);

TextStyle buttonTextStyle = TextStyle(
    fontSize: 13.0,
    color: ColorConstants.kWhiteColor,
    fontWeight: kFontWeightBold);

TextStyle buttonTextStyle1 = TextStyle(
    fontSize: 18.0,
    color: ColorConstants.kWhiteColor,
    fontWeight: kFontWeightBold);

TextStyle textButtonTextStyle = TextStyle(
    fontSize: 16.0,
    color: ColorConstants.kBlackColor,
    fontWeight: kFontWeight400);

TextStyle subtitleTextStyle = TextStyle(
    color: ColorConstants.kHeadingTextColor, fontWeight: kFontWeightBold);

TextStyle titleTextStyle = TextStyle(
  fontSize: 30.0,
  color: ColorConstants.kHeadingTextColor,
  fontWeight: kFontWeight900,
);

TextStyle greetingTextStyle = TextStyle(
    fontSize: 18.0, color: Colors.black87, fontWeight: kFontWeightBold);

EdgeInsets edgeInsets = const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0);

final formatDay = DateFormat("EEE");
final formatDate = DateFormat("d MMM");

class CustomTextField extends StatelessWidget {
  final String? fieldText;
  final TextEditingController? fieldController;
  final bool? isEnabled;
  final Function(String)? onPressed;
  final icon;
  final icons;
  final obscureText;

  const CustomTextField({
    Key? key,
    this.fieldText,
    this.fieldController,
    this.isEnabled,
    this.onPressed,
    this.icon,
    this.icons,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: fieldController,
      enabled: isEnabled,
      decoration: InputDecoration(
        hintText: fieldText,
        hintStyle: const TextStyle(
            fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.w400),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        prefixIcon: icon,
        suffixIcon: icons,
      ),
      cursorColor: Colors.grey,
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final AlignmentGeometry align;
  final VoidCallback? onPressed;
  final Widget child;

  const CustomTextButton({
    Key? key,
    this.align = Alignment.bottomRight,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: TextButton(
        onPressed: () {},
        child: child,
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final Function()? onPressed;
  final Widget child;
  final Color beginColor;
  final Color endColor;
  final double elevation;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width = double.infinity,
    this.height = 42.0,
    this.beginColor = const Color(0xFF2196F3),
    this.endColor = const Color(0xFFA364AE),
    this.gradient =
        const LinearGradient(colors: [Color(0xFF2196F3), Color(0xFFA364AE)]),
    this.elevation = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(20);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
