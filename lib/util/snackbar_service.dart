import 'package:flutter/material.dart';
import 'package:rhst/app.dart';
import 'package:rhst/util/logger.dart';

class SnackbarService {
  void display(String text, {bool isError = false}) {
    Logger.log(text);
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
