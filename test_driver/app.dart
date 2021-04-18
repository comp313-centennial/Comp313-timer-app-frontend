import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timer_app/main.dart' as app;
import 'package:timer_app/utils/simple_bloc_observer.dart';

void main() async {
  enableFlutterDriverExtension(handler: (command) async {
    switch (command) {
      case 'restart':
        _runApp();
        return 'ok';
    }
    throw Exception('Unknown command');
  });
  await Firebase.initializeApp();
  _runApp();
}

void _runApp() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(app.MyApp());
}
