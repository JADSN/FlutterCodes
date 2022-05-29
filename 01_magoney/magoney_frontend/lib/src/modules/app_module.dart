import 'package:flutter/material.dart';
import 'package:magoney_frontend/src/modules/fc_module/fc_records_page.dart';
import 'package:magoney_frontend/src/modules/fc_papers_accounts/fc_papers_accounts_page.dart';
import 'package:magoney_frontend/src/modules/home_module/home_page.dart';

import '../constants/route_constants.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magoney',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: homeRoute,
      routes: {
        homeRoute: (context) => const HomePage(),
        fcRecordsRoute: (context) => const FcRecordsPage(),
        fcPapersAccountsRoute: (context) => FcPapersAccountsPage(),
      },
    );
  }
}
