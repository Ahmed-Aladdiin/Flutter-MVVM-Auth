import 'package:flutter/material.dart';

void snackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
      ),
    );
}
