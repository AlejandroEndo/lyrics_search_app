import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorResult extends StatelessWidget {
  ErrorResult({Key key, @required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(message),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.blue,
          child: Text('Ok'),
        ),
      ],
    );
  }
}
