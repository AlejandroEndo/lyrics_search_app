import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text('No se encontró lo que buscabas'),
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
