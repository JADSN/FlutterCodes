import 'package:fluttask/pages/home/home_container.dart';
import 'package:fluttask/pages/home/home_controller.dart';
import 'package:fluttask/exceptions/result.dart';
import 'package:fluttask/models/task_model.dart';
import 'package:fluttask/repositories/task_repository_client_http_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();

    _controller = HomeController(
      TaskRepositoryClientHttpImpl(),
    );

    _controller.taskDescriptionController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    super.dispose();

    _controller.taskDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
      children: [
        ValueListenableBuilder<Future<Result<List<Task>>>>(
          valueListenable: _controller.listTaskNotifier,
          builder: (_, __, ___) => HomeContainer(
            controller: _controller,
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: const Icon(Icons.plus_one),
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add item'),
                  content: TextFormField(
                    onChanged: (String value) =>
                        _controller.taskDescriptionController.text = value,
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                    ),
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () async {
                        await _controller.insertOne(
                            _controller.taskDescriptionController.text);

                        Navigator.pop(context, 'OK');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
