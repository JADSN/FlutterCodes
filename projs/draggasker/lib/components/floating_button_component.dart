import 'package:flutter/material.dart';

class FloatingButtonComponent extends StatefulWidget {
  final String titleDialog;
  final Icon icon;
  final Color color;
  final VoidCallback onPressed;
  final ValueChanged onChanged;

  const FloatingButtonComponent({
    Key? key,
    required this.titleDialog,
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FloatingButtonComponentState createState() =>
      _FloatingButtonComponentState();
}

class _FloatingButtonComponentState extends State<FloatingButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: widget.color,
      child: widget.icon,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(widget.titleDialog),
              content: TextField(
                onChanged: (newValue) => widget.onChanged(newValue),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                    side: const BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                    side: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2.0,
                    ),
                  ),
                  onPressed: widget.onPressed,
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
