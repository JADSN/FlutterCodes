import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[Color(0xffe94976), Color(0xffed7263)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back_ios)),
              ),
              const Spacer(flex: 3),
              const FlutterLogo(size: 60),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "By tapping Create Account or Sign In, you agree to our"),
                      TextSpan(text: " "),
                      TextSpan(
                        text: "Terms",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: " "),
                      TextSpan(text: "Learn how we process your data int our"),
                      TextSpan(text: " "),
                      TextSpan(
                        text: "Privacy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: " "),
                      TextSpan(
                        text: "Policy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: " "),
                      TextSpan(
                        text: "Cookies Policy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.ac_unit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SIGN IN WITH APPLE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.ac_unit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SIGN IN WITH FACEBOOK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.ac_unit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SIGN IN WITH PHONE NUMBER",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                "Trouble Signing In?",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 5,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xff2d3127),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
