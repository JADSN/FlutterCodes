import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:rsc/constants/colors.dart';
import 'package:rsc/pages/home_page.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "OBRIGADO !!!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: btnDoAnotherReportTextEnabled,
                  backgroundColor: btnDoAnotherReportBgEnabled,
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Text(
                  'FAZER OUTRO RELATÓRIO',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: kIsWeb == false,
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: btnCloseTextEnabled,
                    backgroundColor: btnCloseBgEnabled,
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // ignore: todo
                    // TODO: If target for android use SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    exit(0);
                  },
                  child: const Text('Sair'),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
