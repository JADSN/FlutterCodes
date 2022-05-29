import 'package:flutter/material.dart';

import 'package:magoney_frontend/constants/routes.dart';

import 'package:magoney_frontend/modules/receipt_module/pages/recipt_page.dart';
import 'package:magoney_frontend/modules/home_module/pages/home_page.dart';
import 'package:magoney_frontend/modules/records_module/pages/records_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magoney',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purpleAccent,
        ),
      ),
      initialRoute: homeRoute,
      routes: {
        homeRoute: (context) => const HomePage(),
        recordsRoute: (context) => const RecordsPage(),
        receiptRoute: (context) => const ReceiptPage(),
      },
    );
  }
}
