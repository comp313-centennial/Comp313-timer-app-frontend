class FormValidator {
  static String formValidation(String value) {
    return value.isEmpty ? "Cannot be empty" : null;
  }

  static String emailAddressValidator(String val) {
    if (isFalsy(val)) {
      return "Invalid email";
    }
    val = val.trim();
    if (!validateEmail(val)) {
      return "Invalid email";
    }
    return null;
  }

  static bool isFalsy(String val) => val == null || val.trim().isEmpty;

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

}