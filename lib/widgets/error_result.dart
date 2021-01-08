import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_search_app/constants.dart';

class ErrorResult extends StatelessWidget {
  ErrorResult({Key key, @required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    // Error window template.
    return AlertDialog(
      title: Text(
        'Error',
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: lightGray),
      ),
      // Feedback message
      content: Text(message, style: TextStyle(color: lightGray)),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          color: pink,
          child: Text('Ok', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
