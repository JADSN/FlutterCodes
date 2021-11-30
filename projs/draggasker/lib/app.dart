import 'package:draggasker/modules/kaban/kaban_controller.dart';
import 'package:draggasker/modules/kaban/kaban_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KabanController()),
      ],
      child: const MaterialApp(
        home: KabanPage(),
      ),
    );
  }
}
