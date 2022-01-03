import 'package:fluttask/exceptions/result.dart';
import 'package:fluttask/models/task_model.dart';
import 'package:fluttask/pages/home/home_controller.dart';
import 'package:fluttask/pages/home/home_exception.dart';
import 'package:fluttask/pages/home/home_loading.dart';
import 'package:fluttask/pages/home/home_ok.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  final HomeController controller;

  const HomeContainer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<List<Task>>>(
      future: controller.readAll(),
      builder: (
        BuildContext context,
        AsyncSnapshot<Result<List<Task>>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const HomeLoading();
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }

        if (snapshot.hasData) {
          var dataResult = snapshot.data!;

          if (dataResult is Error) {
            var error = (dataResult as Error).exception;
            return HomeException(exception: error);
          }

          final List<Task> tasks = (dataResult as Success).value;

          return HomeOk(controller: controller, tasks: tasks);
        }

        return Container(
          color: Colors.amberAccent,
        );
      },
    );
  }
}
