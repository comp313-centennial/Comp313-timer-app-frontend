import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timer_app/blocs/auth/bloc.dart';
import 'package:timer_app/common/constants.dart';
import 'package:timer_app/data/user_repo.dart';
import 'package:meta/meta.dart';
import 'package:timer_app/models/LoginCredentials.dart';
import 'package:timer_app/models/User.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepo userRepo;
  final AuthBloc authBloc;


  LoginBloc({
    @required this.userRepo,
    @required this.authBloc,
  })  : super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AttemptLoginEvent) {
      yield* _handleAttemptLogin(event);
    } else if (event is LoginErrorEvent) {
      yield LoginErrorState(error: event.error);
    } else if (event is SendResetPasswordLinkEvent) {
      yield* _handleSendResetPasswordLink(event);
    } else if (event is SignUpEvent) {
      yield* _handleSignUpEvent(event);
    } else if(event is SignInWithEmailLinkEvent) {
      yield* _handleSignInWithEmailLinkEvent(event);
    } else if(event is HandleLinkEvent) {
      yield* _handleHandleLinkEvent(event);
    } else if(event is SendVerificationEvent) {
      yield* _handleSendVerificationEvent(event);
    } else if(event is SignInWithPhoneEvent) {
      yield* _handleSignInWithPhoneEvent(event);
    }
  }

  Stream<LoginState> _handleAttemptLogin(AttemptLoginEvent event) async* {
    yield LoginLoadingState();
    try {
      User user = await userRepo.loginWithEmailPass(event.data);
      globalFirebaseUser = user;
      globalUser = await userRepo.getUserFromDb(event.data.email);
      authBloc.login(user);
      yield LoginSuccessState(user: user);
    } catch (e) {
      yield LoginErrorState(error: e.toString());
    }
  }

  Stream<LoginState> _handleSendResetPasswordLink(SendResetPasswordLinkEvent event) async* {
    yield LoginLoadingState();
    try {
      await userRepo.sendResetPasswordLink(event.email);
      yield ResetPasswordSuccessState();
    } catch (e) {
      yield LoginErrorState(error: e.toString());
    }
  }

  Stream<LoginState> _handleSendVerificationEvent(SendVerificationEvent event) async* {
    yield LoginLoadingState();
    try {
      StreamController<LoginState> eventStream = StreamController();
      PhoneVerificationCompleted verificationCompleted =
          (PhoneAuthCredential phoneAuthCredential) async {
        User user = userRepo.getUser();
        authBloc.login(user);
        eventStream.add(LoginSuccessState(user: user));
        eventStream.close();
        print("Phone number automatically verified and user signed in");
      };

      //Listens for errors with verification, such as too many attempts
      PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) async {
        eventStream.add(LoginErrorState(error: authException.message));
        eventStream.close();
      };

      //Callback for when the code is sent
      PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
        eventStream.add(SendVerificationCodeSuccessState(verificationId: verificationId));
        eventStream.close();
      };

      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
        print(verificationId);
        eventStream.close();
      };
      await userRepo.sendOtpVerificationCode(event.phone, verificationFailed, verificationCompleted, codeSent, codeAutoRetrievalTimeout);
      yield* eventStream.stream;
    } catch (e) {
      yield LoginErrorState(error: e.toString());
    }
  }

  Stream<LoginState> _handleSignInWithPhoneEvent(SignInWithPhoneEvent event) async* {
    yield LoginLoadingState();
    try {
      User user = await userRepo.loginWithPhoneNumber(event.verificationId, event.verificationCode);
      authBloc.login(user);
      yield LoginSuccessState(user: user);
      yield ResetPasswordSuccessState();
    } catch (e) {
      yield LoginErrorState(error: e.toString());
    }
  }

  Stream<LoginState> _handleSignUpEvent(SignUpEvent event) async* {
    yield LoginLoadingState();
    try {
      UserModel user = await userRepo.signUpWithEmail(event.email, event.password, event.name, event.phone);
      yield SignUpEventSuccessState();
    } catch (e) {
      yield LoginErrorState(error: e.toString());
    }
  }

  Stream<LoginState> _handleSignInWithEmailLinkEvent(SignInWithEmailLinkEvent event) async* {
    yield LoginLinkLoadingState();
    try {
      await userRepo.signInWithEmailLink(event.email);
    } catch (e) {
      yield LoginErrorState(error: e.toString());
    }
  }

  Stream<LoginState> _handleHandleLinkEvent(HandleLinkEvent event) async* {
    yield LoginLinkLoadingState();
    try {
      User user = await userRepo.handleSignInLink(event.link, event.email);
      authBloc.login(user);
      yield LoginSuccessState(user: user);
    } catch (e) {
      yield LoginErrorState(error: e.toString());
    }
  }

  login(LoginCredentials data) {
    add(AttemptLoginEvent(data));
  }

  onLoginError(String message) {
    add(LoginErrorEvent(error: message));
  }

  sendResetPassword(String email) {
    add(SendResetPasswordLinkEvent(email: email));
  }

  singUpWithEmail(String email, String password, String name, String phone) {
    add(SignUpEvent(email: email, password: password, name: name, phone: phone));
  }

  loginWithEmailLink(String email) {
    add(SignInWithEmailLinkEvent(email: email));
  }

  handleLink(Uri link, String email) {
    add(HandleLinkEvent(link: link, email: email));
  }

  loginWithPhoneNumber(String verificationId, String verificationCode) {
    add(SignInWithPhoneEvent(verificationId: verificationId, verificationCode: verificationCode));
  }

  sendVerificationPin(String phone) {
    add(SendVerificationEvent(phone: phone));
  }
}
