part of login;

class ValidationModel {
  String? value;
  String? error;
  ValidationModel(this.value, this.error);
}

ValidationModel validateEmail(String? val) {
  if (val != null && val.isValidEmail) {
    return ValidationModel(val, null);
  } else if (val?.isEmpty == true) {
    return ValidationModel(null, "Email is required");
  } else {
    return ValidationModel(null, "Invalid Email address");
  }
}

ValidationModel validatePassword(String? val) {
  if (val != null && val.isValidPassword && val.isNotEmpty) {
    return ValidationModel(val, null);
  } else if (val!.isEmpty) {
    return ValidationModel(null, "Password is required");
  } else {
    return ValidationModel(null, "Invalid Password");
  }
}
