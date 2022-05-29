import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magoney_frontend/constants/routes.dart';
import 'package:magoney_frontend/widgets/custom_drawer_widget.dart';

import '../../../widgets/custom_app_bar_widget.dart';

// ignore: todo
// TODO: Try: Controller cursor always go to end
// https://stackoverflow.com/questions/44955063/how-can-i-limit-the-size-of-a-text-field-in-flutter

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String congregationName = "";
  String cityName = "";
  String stateName = "";

  String monthName = 'Janeiro';
  int year = DateTime.now().year;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        appBarTitleText: "Início",
      ),
      drawer: const CustomDrawerWidget(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.deepPurple,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Nome da congregação',
                  label: Text(
                    "Nome da congregação",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 3.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String newValue) => setState(
                  () => congregationName = newValue,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.deepPurple,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Nome da cidade',
                  label: Text(
                    "Nome da cidade",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 3.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String newValue) => setState(
                  () => cityName = newValue,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.deepPurple,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Nome do estado',
                  label: Text(
                    "Nome do estado",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 3.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String newValue) => setState(
                  () => cityName = newValue,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  primary: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ADICIONAR REGISTROS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () => Navigator.of(context).pushNamed(recordsRoute),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
