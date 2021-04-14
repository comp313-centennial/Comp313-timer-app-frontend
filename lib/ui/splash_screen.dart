import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/blocs/auth/auth_bloc.dart';
import 'package:timer_app/blocs/auth/auth_state.dart';
import 'package:timer_app/utils/dependency_provider.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreenPage> {
  AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _authBloc,
      listener: _authStateListener,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.22,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/app-logo.png'),
            ),
          ],
        ),
      ),
    );
  }

  _authStateListener(BuildContext context, AuthState state) {
    Timer(Duration(seconds: 3), () {
      if (state is AuthAuthenticatedState) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (state is AuthUnauthenticatedState) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void didChangeDependencies() {
    _authBloc = DependencyProvider.of(context).authBloc;
    super.didChangeDependencies();
  }
}
