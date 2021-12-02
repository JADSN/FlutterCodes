import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var items = List<String>.generate(10, (_) => 'Item');

  var qtdeClientStamps = 10;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/clients');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            child: const Text(
              "I AM OWNER",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
