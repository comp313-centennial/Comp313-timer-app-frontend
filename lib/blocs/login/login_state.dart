import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => const [];
}

class InitialLoginState extends LoginState {
  @override
  String toString() {
    return '${(InitialLoginState).toString()}{}';
  }
}

class LoginLoadingState extends LoginState {
  @override
  String toString() {
    return '${(LoginLoadingState).toString()}{}';
  }
}

class LoginLinkLoadingState extends LoginState {
  @override
  String toString() {
    return '${(LoginLinkLoadingState).toString()}{}';
  }
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({this.error});

  @override
  String toString() {
    return '${(LoginErrorState).toString()}{error: $error}';
  }
}

class LoginSuccessState extends LoginState {
  final User user;

  LoginSuccessState({this.user});

  @override
  String toString() {
    return '${(LoginSuccessState)}{user: $user}';
  }
}

class ResetPasswordSuccessState extends LoginState {
  @override
  String toString() {
    return '${(ResetPasswordSuccessState).toString()}{}';
  }
}

class SendVerificationCodeSuccessState extends LoginState {
  final String verificationId;
  SendVerificationCodeSuccessState({this.verificationId});
  @override
  String toString() {
    return '${(SendVerificationCodeSuccessState).toString()}{verificationId: $verificationId}';
  }
}

class SignUpEventSuccessState extends LoginState {
  @override
  String toString() {
    return '${(SignUpEventSuccessState).toString()}{}';
  }
}

class LoginPhoneLoadingState extends LoginState {
  @override
  String toString() {
    return '${(LoginPhoneLoadingState).toString()}{}';
  }
}