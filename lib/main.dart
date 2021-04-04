import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/routes.dart';
import 'package:timer_app/ui/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timer_app/utils/dependency_provider.dart';
import 'package:timer_app/utils/simple_bloc_observer.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(DependencyProvider(child: MyApp()));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
    cubit: _authBloc,
    builder: (context, state) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: DependencyProvider.of(context).navigationBloc.navigatorKey,
        color: Colors.amber,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
      );
    }
    );
  }

  @override
  void didChangeDependencies() {
    if (_authBloc == null) {
      _authBloc = DependencyProvider.of(context).authBloc;
      _authBloc.add(AppStartedEvent());
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    DependencyProvider.of(context).dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}