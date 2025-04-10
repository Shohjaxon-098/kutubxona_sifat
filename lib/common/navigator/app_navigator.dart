import 'package:flutter/material.dart';

class AppNavigator {
  static void pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }

  static void pushNamedAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.restorablePushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }

  static void pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}