final email = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final phone = RegExp(r"^[\d]{10}$");

String keyType(String key) {
  if (phone.hasMatch(key)) {
    return "phone";
  } else {
    return "email";
  }
}
