import 'package:flutter/material.dart';
import 'package:lyrics_search_app/constants.dart';

class IconActionButton extends StatelessWidget {
  const IconActionButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    // Action Button of appbar.
    return IconButton(
      icon: Icon(icon, color: pink),
      onPressed: onPressed,
    );
  }
}
