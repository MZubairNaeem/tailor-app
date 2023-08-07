import 'package:ect/Constants/colors.dart';
import 'package:flutter/material.dart';

showSnackBar(
  BuildContext context,
  String content,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: customPurple,
      content: Text(
        content,
        style: const TextStyle(color: customWhite, fontWeight: FontWeight.bold),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
