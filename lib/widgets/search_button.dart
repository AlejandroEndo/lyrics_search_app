import 'package:flutter/material.dart';
import 'package:lyrics_search_app/constants.dart';

class SearchButton extends StatelessWidget {
  final Function() onPressed;
  SearchButton({Key key, @required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: MaterialButton(
        onPressed: onPressed,
        color: pink,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'Search',
          style: TextStyle(
              color: white, fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
      ),
    );
  }
}
