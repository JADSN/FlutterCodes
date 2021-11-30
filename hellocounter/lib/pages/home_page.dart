import 'package:flutter/material.dart';
import 'package:hellocounter/constants/colors.dart';
import 'package:hellocounter/widgets/counter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            MyCounterWidget(
              "You clicked 1",
              -5,
              5,
              lessThanColor,
              zeroColor,
              greaterThanColor,
            ),
            MyCounterWidget(
              "You clicked 2",
              -5,
              5,
              lessThanColor,
              zeroColor,
              greaterThanColor,
            ),
          ],
        ),
      ),
    );
  }
}
