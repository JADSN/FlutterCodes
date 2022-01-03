import 'package:fluttask/failures/tasks_failures.dart';
import 'package:flutter/material.dart';

class HomeException extends StatelessWidget {
  final Exception exception;

  const HomeException({
    Key? key,
    required this.exception,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (exception is NotFoundTaskFailure) {
      var error = (exception as NotFoundTaskFailure).msgError;

      return Center(
        child: Text(
          error.toString(),
        ),
      );
    } else {
      return Center(
        child: Text(
          exception.toString(),
        ),
      );
    }
  }
}
