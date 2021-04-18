import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../screens/home_screen_driver.dart';
import '../screens/login_screen_driver.dart';
import '../test_helper.dart';

void testLoginJourney() {
  group('Login Journey', () {
    FlutterDriver driver;
    LoginScreenDriver loginScreen;
    HomeScreenDriver homeScreen;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      loginScreen = LoginScreenDriver(driver: driver);
      homeScreen = HomeScreenDriver(driver: driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    setUp(() async {
      await driver.requestData('restart');
    });

    test('flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('email validation', () async {
      await loginScreen.enterEmail('');
      await loginScreen.submit();
      await driver.waitFor(find.text("Cannot be empty"));

      await loginScreen.enterEmail('invalid email@example.com');
      await loginScreen.enterPassword('password');
      await loginScreen.submit();
      await driver.waitFor(find.text("[firebase_auth/invalid-email] The email address is badly formatted."));
      await wait(1000);
    });

    test('invalid credentials', () async {
      await loginScreen.enterEmail('invalid-user@example.com');
      await loginScreen.enterPassword('password');
      await loginScreen.submit();
      await driver.waitFor(find.text("Error: userId or password is invalid"));
      await wait(1000);
    });

    test('successful login', () async {
      await loginScreen.enterEmail('sampathnarayanan72@gmail.com');
      await loginScreen.enterPassword('password');
      await loginScreen.submit();
      await driver.waitFor(homeScreen.navigationBarFinder);
      await wait(1000);
    });
  });
}
