import 'package:flutter/material.dart';

class NavService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState get navigator => navigatorKey.currentState!;

  static void navigateTo(String routeName) {
    navigator.pushNamed(routeName);
  }

  static void pop() {
    navigator.pop();
  }

  static void replaceWith(String routeName) {
    navigator.pushReplacementNamed(routeName);
  }

  static void clearAndNavigateTo(String routeName) {
    navigator.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}