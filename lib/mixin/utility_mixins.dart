import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

mixin UtilityMixin {
  void navigationPush(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(microseconds: 200),
        child: screen,
      ),
    );
  }
}
