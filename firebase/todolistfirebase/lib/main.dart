import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolistfirebase/firebase_options.dart';

import 'package:todolistfirebase/app.dart';

const useEmulator = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _connectToFirebaseEmulator();

  runApp(const App());
}

Future _connectToFirebaseEmulator() async {
  const String host = "localhost";
  const int port = 8080;

  if (useEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator(host, port);
  }
}
