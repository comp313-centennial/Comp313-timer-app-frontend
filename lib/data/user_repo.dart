import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:timer_app/models/LoginCredentials.dart';

class UserRepo {
  User user;
  final firebaseAuth = FirebaseAuth.instance;

  Future<User> loginWithEmailPass(LoginCredentials loginCredentials) async {
    final methods = await firebaseAuth.fetchSignInMethodsForEmail(loginCredentials.email);
    if (methods.contains('password')) {
      final result = await firebaseAuth.signInWithEmailAndPassword(email: loginCredentials.email, password: loginCredentials.password);
      return result.user;
    } else {
      throw "UserId or password is incorrect";
    }
  }

  signInWithEmailLink(String email) async {
    await firebaseAuth
        .sendSignInLinkToEmail(
          email: email,
          actionCodeSettings: ActionCodeSettings(
            url: 'https://plustime.page.link/',
            handleCodeInApp: true,
            iOSBundleId: 'com.nordicloop.plustime',
            androidPackageName: 'com.nordicloop.plustime',
            androidInstallApp: true,
            androidMinimumVersion: "1",
          ),
        )
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) => print('Successfully sent email verification'));
  }

  sendOtpVerificationCode(String phone, verificationFailed, verificationCompleted, codeSent, codeAutoRetrievalTimeout) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      throw "Failed to Verify Phone Number: $e";
    }
  }

  handleSignInLink(Uri link, String email) async {
    if (link != null) {
      final User user = (await firebaseAuth.signInWithEmailLink(
        email: email,
        emailLink: link.toString(),
      )).user;
      if (user != null) {
        return user;
      } else {
        throw "An unexpected error occured";
      }
    } else {
      throw "An unexpected error occured";
    }
  }

  Future<User> signUpWithEmail(String email, String password, String name) async {
    final methods = await firebaseAuth.fetchSignInMethodsForEmail(email);
    if (methods.isEmpty) {
      try {
        final result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        this.user = result.user;
        this.user..updateProfile(displayName: name);
        return user;
      } on PlatformException catch (e) {
        throw e.message;
      }
    } else {
      throw "Something went wrong";
    }
  }

  Future<User> loginWithPhoneNumber(String verificationId, String verificationCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );
      final User user = (await firebaseAuth.signInWithCredential(credential)).user;
      return user;
    } catch (e) {
      throw "Failed to sign in: " + e.toString();
    }
  }

  Future<void> logout() async {
    return firebaseAuth.signOut();
  }
  
  Future<bool> isLoggedIn() async {
    user = firebaseAuth.currentUser;
    return user != null;
  }

  User getUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> sendResetPasswordLink(String email) async {
    try {
      return await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }
}
