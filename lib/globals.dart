import 'package:flutter/material.dart';

class AppGlobals {
  static GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();

  static NavigatorState? get nav => rootNavKey.currentState;
}