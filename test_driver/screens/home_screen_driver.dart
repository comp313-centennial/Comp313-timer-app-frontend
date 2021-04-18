import 'package:flutter_driver/flutter_driver.dart';

class HomeScreenDriver {
  final FlutterDriver driver;
  final navigationBarFinder = find.byValueKey("navigation_bar");

  HomeScreenDriver({
    this.driver,
  });
}
