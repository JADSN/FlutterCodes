import 'package:flutter/material.dart';

class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();

  final secretKey = GlobalKey<ScaffoldState>();

  void showSnackbar(SnackBar snackBar) {
    ScaffoldMessenger.of(secretKey.currentContext!).showSnackBar(snackBar);
  }
}
