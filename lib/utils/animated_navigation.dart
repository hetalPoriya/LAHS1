import 'package:flutter/material.dart';
class AnimatedNavigation extends Navigator {
  const AnimatedNavigation({Key? key}) : super(key: key);

  static SlideTransition _transition(
      Widget child, Animation<double> animation) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static pushAnimatedNavigation(context, Widget pageName) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => pageName,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            _transition(child, animation),
      ),
    );
  }

  static pushReplacementAnimatedNavigation(context, Widget pageName) {
    return Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => pageName,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            _transition(child, animation),
      ),
    );
  }
}
