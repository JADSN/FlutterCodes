import 'package:flutter/material.dart';

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
    MaterialState.disabled,
    MaterialState.selected,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.deepPurple;
  }
  return Colors.deepPurple;
}
