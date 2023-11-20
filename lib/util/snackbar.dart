import 'package:flutter/material.dart';

class ReusableSnackbar {
  static void showSnackbar(BuildContext context, String message, Color color) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Defina a duração desejada do Snackbar
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
