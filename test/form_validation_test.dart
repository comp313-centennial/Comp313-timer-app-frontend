import 'package:timer_app/utils/FormValidator.dart';
import 'package:test/test.dart';

void main() {
  group('Validator', () {

    test('Password Test', () {
      expect(FormValidator.formValidation(''), "Cannot be empty");
      expect(FormValidator.formValidation('validPass'), null);
    });

    test('Email Test', () {
      expect(FormValidator.emailAddressValidator(''), "Invalid email");
      expect(FormValidator.emailAddressValidator('test.com'), "Invalid email");
      expect(FormValidator.emailAddressValidator('test@test.1'), "Invalid email");
      expect(FormValidator.emailAddressValidator('test@test.com'), null);
    });
  });
}