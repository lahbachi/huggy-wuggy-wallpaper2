class Validator {
  String?   validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "is Required";
    } else if (!regExp.hasMatch(value)) {
      return "must be a-z and A-Z";
    }
    return null;
  }

  String? validateMobile(String value) {
    String pattern = r'(^[1-9]{1}[0-9]{8}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Mobile is Required";
    } else if (value.length > 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "example 611111111";
    }
    return null;
  }

  String? validatePasswordLength(String value) {
    if (value.isEmpty) {
      return " can't be empty";
    } /*else if (value.length < 3) {
    return "Password must be longer than 10 characters";
  }*/
    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return "phone is Required";
    } else {
      return null;
    }
  }
}
