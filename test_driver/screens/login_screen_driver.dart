import 'package:flutter_driver/flutter_driver.dart';

import '../test_helper.dart';

class LoginScreenDriver {
  final FlutterDriver driver;
  final emailInputFinder = find.byValueKey("email_input");
  final passwordInputFinder = find.byValueKey("password_input");
  final loginButtonFinder = find.byValueKey("login_submit_btn");


  LoginScreenDriver({
    this.driver,
  });

  enterEmail(String email) async {
    await driver.tap(emailInputFinder);
    await wait(200);
    await driver.enterText(email);
    await wait(300);
  }

  enterPassword(String password) async {
    await driver.tap(passwordInputFinder);
    await wait(200);
    await driver.enterText(password);
    await wait(300);
  }

  submit() async {
    await driver.tap(loginButtonFinder);
  }
}
