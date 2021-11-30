import 'dart:math';

import 'package:flutter/material.dart';

MaterialColor getRandomColor() =>
    Colors.primaries[Random().nextInt(Colors.primaries.length)];
