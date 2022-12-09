import 'package:flutter/material.dart';
import 'package:rhst/main_dev.dart';

class SnackbarService {
  void display(String text, {bool isError = false}) {
    print(text);
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(text)],
        ),
      ),
    );
  }
}
