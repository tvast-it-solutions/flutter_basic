import 'package:flutter/material.dart';

Widget customTextField(TextEditingController controller, String labelText,
    {bool isObscure = false}) {
  return TextFormField(
    controller: controller,
    obscureText: isObscure,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),
  );
}
