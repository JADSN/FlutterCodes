import 'package:flutter/material.dart';
import 'package:rsc/pages/tabs/home_tab.dart';
import 'package:rsc/pages/tabs/list_of_reports.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime actualDate = DateTime.now();
  String previousMonth = "";

  // * Tabs
  final List<Tab> tabsAppBar = <Tab>[
    const Tab(
      icon: Icon(Icons.home),
      text: 'Início',
    ),
    const Tab(
      icon: Icon(Icons.list_alt),
      text: 'Relatórios',
    ),
  ];

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    DateTime newDate = DateTime(date.year, date.month - 1, date.day);
    // print("[NEW DATE]" + newDate.toIso8601String());
    switch (newDate.month) {
      case 1:
        previousMonth = "JANEIRO";
        break;
      case 2:
        previousMonth = "FEVEREIRO";
        break;
      case 3:
        previousMonth = "MARÇO";
        break;
      case 4:
        previousMonth = "ABRIL";
        break;
      case 5:
        previousMonth = "MAIO";
        break;
      case 6:
        previousMonth = "JUNHO";
        break;
      case 7:
        previousMonth = "JULHO";
        break;
      case 8:
        previousMonth = "AGOSTO";
        break;
      case 9:
        previousMonth = "SETEMBRO";
        break;
      case 10:
        previousMonth = "OUTUBRO";
        break;
      case 11:
        previousMonth = "NOVEMBRO";
        break;
      case 12:
        previousMonth = "DEZEMBRO";
        break;
      default:
        previousMonth = "ANOTHER";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: tabsAppBar.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: tabsAppBar,
            ),
            title: Text(
              "RELATÓRIO DE SERVIÇO DE CAMPO - $previousMonth",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              HomeTab(),
              ListOfReportsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
