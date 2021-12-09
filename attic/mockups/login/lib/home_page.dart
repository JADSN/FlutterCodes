import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//* Components
import 'package:login/components/text_bold_center.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            const FlutterLogo(
              size: 72,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextBoldCenter(
                    text: "Get your Money",
                    textColor: Colors.white,
                    fontSize: 24,
                  ),
                  TextBoldCenter(
                    text: "Under Control",
                    textColor: Colors.white,
                    fontSize: 24,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: const TextBoldCenter(
                      text: "Manage your expenses",
                      textColor: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const TextBoldCenter(
                    text: "Seamlessly",
                    textColor: Colors.grey,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            const Spacer(),
            LayoutBuilder(
              builder: (_, constrains) {
                var maxWidth = constrains.maxWidth;

                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: ElevatedButton(
                        child: const Text("Sign Up with Email ID"),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff5f55eb),
                          minimumSize: maxWidth >= 1024
                              ? Size(maxWidth / 2.5, 40)
                              : const Size(double.infinity, 40),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      width:
                          maxWidth >= 1024 ? maxWidth / 2.53 : double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/icons8google36.png",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Sign Up with Google",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            RichText(
              text: const TextSpan(
                text: 'Already have an account?  ',
                style: TextStyle(
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
