import 'package:flutter/material.dart';

Widget customButton(String text, void Function() onPressed,
    {bool isDisabled = false, double width = 0}) {
  return ElevatedButton(
    onPressed: isDisabled ? null : onPressed,
    style: ElevatedButton.styleFrom(
        textStyle:
            const TextStyle(fontSize: 14, color: Colors.white, height: 1),
        backgroundColor: const Color(0xFF175051),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        minimumSize: width == 0 ? const Size.fromHeight(50) : Size(width, 50)),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}
