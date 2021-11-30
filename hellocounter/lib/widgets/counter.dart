import 'package:flutter/material.dart';

class MyCounterWidget extends StatefulWidget {
  final String label;
  final int minCount;
  final int maxCount;
  final Color negativeColor;
  final Color neutralColor;
  final Color positiveColor;

  // ignore: use_key_in_widget_constructors
  const MyCounterWidget(
    this.label,
    this.minCount,
    this.maxCount,
    this.negativeColor,
    this.neutralColor,
    this.positiveColor,
  );

  @override
  State<MyCounterWidget> createState() => _MyCounterWidgetState();
}

class _MyCounterWidgetState extends State<MyCounterWidget> {
  int count = 0;
  Color actualColor = Colors.purple;

  void _changeFloatIconColor() {
    if (count == 0) {
      actualColor = widget.neutralColor;
    } else if (count > 0) {
      actualColor = widget.positiveColor;
    } else {
      actualColor = widget.negativeColor;
    }
  }

  void _incrementCounter() {
    setState(() {
      count++;
      _changeFloatIconColor();
    });
  }

  void _decrementCounter() {
    setState(() {
      count--;
      _changeFloatIconColor();
    });
  }

  void _resetCounter() {
    setState(() {
      count = 0;
      _changeFloatIconColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            widget.label,
            style: TextStyle(color: actualColor, fontSize: 48),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            '$count',
            style: TextStyle(color: actualColor, fontSize: 48),
          ),
        ),
        SizedBox(
          width: 150,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: count != widget.minCount,
                  child: FloatingActionButton(
                    onPressed: _decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                    mini: true,
                    backgroundColor: actualColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: count != 0,
                  child: FloatingActionButton(
                    onPressed: _resetCounter,
                    tooltip: 'Reset',
                    child: const Icon(Icons.adjust_rounded),
                    mini: true,
                    backgroundColor: actualColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: count != widget.maxCount,
                  child: Visibility(
                    visible: true,
                    child: FloatingActionButton(
                      onPressed: _incrementCounter,
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                      mini: true,
                      backgroundColor: actualColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
