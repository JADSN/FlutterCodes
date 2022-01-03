import 'package:flutter/material.dart';

import 'package:fluttask/pages/home/home_controller.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: CircularProgressIndicator(),
        ),
        SizedBox(height: 20),
        Text(
          "PROCESSING",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
