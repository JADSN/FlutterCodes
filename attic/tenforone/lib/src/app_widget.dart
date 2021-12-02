import 'package:flutter/material.dart';
import 'package:tenforone/src/pages/client_detail_page.dart';
import 'package:tenforone/src/pages/home_page.dart';

import 'package:tenforone/src/pages/list_of_clients_page.dart';
import 'package:tenforone/src/pages/owner_stamp_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/clients': (context) => const ListOfClientsPage(),
        '/client-detail': (context) => const ClientDetailPage(),
        '/owner': (context) => const OwnerStampPage(),
      },
    );
  }
}
