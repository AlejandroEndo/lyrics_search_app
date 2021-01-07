import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(),
            TextFormField(),
            MaterialButton(
              onPressed: () {},
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
