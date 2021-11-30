import 'package:codeverifyemail/src/pages/code_is_completed_page.dart';
import 'package:codeverifyemail/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => const HomePage(),
        "/code-is-completed": (_) => const CodeIsCompletedPage(),
      },
      // home: const AppWidget(),
    );
  }
}
