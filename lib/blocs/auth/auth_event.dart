import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]);
  @override
  List<Object> get props => const [];
}

class AppStartedEvent extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedInEvent extends AuthEvent {
  final User user;

  LoggedInEvent({@required this.user}) : super([user]);

  @override
  String toString() {
    return 'LoggedInEvent{user: $user}';
  }
}

class LoggedOutEvent extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}