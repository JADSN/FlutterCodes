import 'package:codeverifyemail/src/pages/verify_code_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text("SEND EMAIL"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VerifyCodePage()),
            );
          },
        ),
      ),
    );
  }
}
