import 'package:timer_app/models/LoginCredentials.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => const [];
}

class AttemptLoginEvent extends LoginEvent {
  final LoginCredentials data;

  AttemptLoginEvent(this.data);

  @override
  String toString() {
    return 'AttemptLoginEvent{data: $data}';
  }
}

class LoginErrorEvent extends LoginEvent {
  final String error;

  LoginErrorEvent({this.error});

  @override
  String toString() {
    return '${(LoginErrorEvent).toString()}{error: $error}';
  }
}

class SendResetPasswordLinkEvent extends LoginEvent {
  final String email;

  SendResetPasswordLinkEvent({this.email});

  @override
  String toString() {
    return '${(SendResetPasswordLinkEvent).toString()}{email: $email}';
  }
}

class SignUpEvent extends LoginEvent {
  final String email;
  final String password;
  final String name;

  SignUpEvent({this.email, this.password, this.name});

  @override
  String toString() {
    return '${(SignUpEvent).toString()}{email: $email, name: $name}';
  }
}

class SignInWithEmailLinkEvent extends LoginEvent {
  final String email;

  SignInWithEmailLinkEvent({this.email});

  @override
  String toString() {
    return '${(SignInWithEmailLinkEvent).toString()}{email: $email}';
  }
}

class HandleLinkEvent extends LoginEvent {
  final Uri link;
  final String email;

  HandleLinkEvent({this.link, this.email});

  @override
  String toString() {
    return '${(HandleLinkEvent).toString()}{link: $link, email: $email}';
  }
}

class SignInWithPhoneEvent extends LoginEvent {
  final String verificationId;
  final String verificationCode;

  SignInWithPhoneEvent({this.verificationId, this.verificationCode});

  @override
  String toString() {
    return '${(SignInWithPhoneEvent).toString()}{verificationId: $verificationId, code: $verificationCode}';
  }
}

class SendVerificationEvent extends LoginEvent {
  final String phone;

  SendVerificationEvent({this.phone});

  @override
  String toString() {
    return '${(SendVerificationEvent).toString()}{phone: $phone}';
  }
}
