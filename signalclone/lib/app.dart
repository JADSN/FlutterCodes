import 'package:flutter/material.dart';
import 'package:signalclone/pages/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Signal',
      home: MyHomePage(),
    );
  }
}
