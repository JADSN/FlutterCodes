import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsc/pages/home.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "OBRIGADO !!!",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.yellow[900],
                backgroundColor: Colors.yellow[400],
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              child: const Text('Fazer outro relaótrio'),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: kIsWeb == false,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red[900],
                  backgroundColor: Colors.red[400],
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
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
          ],
        ),
      )),
    );
  }
}
