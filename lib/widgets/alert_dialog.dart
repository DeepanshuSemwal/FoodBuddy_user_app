import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  final String? message;
  ErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      title: Text("Error!"),
      content: Text(message!),
      actions: [
    TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
      style: TextButton.styleFrom(
        primary: Colors.red,
      ),
    ),

      ],

    );
  }
}
