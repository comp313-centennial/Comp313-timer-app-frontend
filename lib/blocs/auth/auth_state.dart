import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  @override
  List get props => const [];
}

class AuthUninitializedState extends AuthState {
  @override
  String toString() {
    return '${(AuthUninitializedState).toString()}{}';
  }
}

class AuthAuthenticatedState extends AuthState {
  final User user;
  AuthAuthenticatedState(this.user);

  @override
  String toString() {
    return '${(AuthAuthenticatedState).toString()}{user: $user}';
  }
}

class AuthUnauthenticatedState extends AuthState {
  @override
  String toString() {
    return '${(AuthUnauthenticatedState).toString()}{}';
  }
}