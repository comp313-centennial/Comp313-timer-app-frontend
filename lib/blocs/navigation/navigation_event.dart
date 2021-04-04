import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
  @override
  List<Object> get props => const [];
}

class LoggedOutNavigationEvent extends NavigationEvent {
  @override
  String toString() {
    return '${(LoggedOutNavigationEvent).toString()}{}';
  }
}

class LoggedInNavigationEvent extends NavigationEvent {
  final User user;
  LoggedInNavigationEvent(this.user);
  @override
  String toString() {
    return '${(LoggedInNavigationEvent).toString()}{User: $user}';
  }
}

class SignUpNavigationEvent extends NavigationEvent {
  @override
  String toString() {
    return '${(SignUpNavigationEvent).toString()}{}';
  }
}

class ForgotPasswordEvent extends NavigationEvent {
  @override
  String toString() {
    return '${(ForgotPasswordEvent).toString()}{}';
  }
}
