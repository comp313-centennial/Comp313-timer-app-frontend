import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigationBloc() : super(null);

  NavigatorState get navigator => navigatorKey.currentState;

  @override
  Stream<dynamic> mapEventToState(NavigationEvent event) async* {
    if (event is LoggedInNavigationEvent) {
      navigator.pushNamedAndRemoveUntil('/home', (route) => false);
    } else if (event is LoggedOutNavigationEvent) {
      navigator.pushNamedAndRemoveUntil('/login', (route) => false);
    } else if (event is SignUpNavigationEvent) {
      navigator.pushNamed('/register');
    } else if (event is ForgotPasswordEvent) {
      navigator.pushNamed('/forgotPassword');
    }
  }

  goToHome(User user) {
    add(LoggedInNavigationEvent(user));
  }

  goToLogin() {
    add(LoggedOutNavigationEvent());
  }

  goToSignUp() {
    add(SignUpNavigationEvent());
  }

  gotToForgotPasswordPage() {
    add(ForgotPasswordEvent());
  }
}
