import 'package:flutter/material.dart';
import 'package:timer_app/ui/ForgotpasswordPage.dart';
import 'package:timer_app/ui/HomePage.dart';
import 'package:timer_app/ui/LoginPage.dart';
import 'package:timer_app/ui/SignUpPage.dart';
import 'package:timer_app/ui/splash_screen.dart';

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/register': (BuildContext context) => new SignUpPage(),
  '/forgotPassword': (BuildContext context) => new ForgotPasswordPage(),
  '/home': (BuildContext context) => new HomeScreenPage(),
  '/' :          (BuildContext context) => new SplashScreenPage(),
};
