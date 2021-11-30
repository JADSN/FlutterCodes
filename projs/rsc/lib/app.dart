import 'package:flutter/material.dart';
import 'package:rsc/pages/home_page.dart';

import 'report_theme.dart';

class ReportApp extends StatelessWidget {
  const ReportApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ReportTheme.light();

    return MaterialApp(
      theme: theme,
      home: const HomePage(),
    );
  }
}
