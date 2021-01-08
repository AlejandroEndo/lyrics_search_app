import 'package:flutter/material.dart';
import 'package:lyrics_search_app/constants.dart';

class ArtistInputField extends StatelessWidget {
  ArtistInputField({
    Key key,
    @required this.controller,
    @required this.onChanged,
    @required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String value) onChanged;
  final Function(String value) validator;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input text title.
          Text(
            'Artist Name:',
            style: TextStyle(
              fontSize: 15.0,
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 9.0),
          // Input text field.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              textInputAction: TextInputAction.done,
              style: TextStyle(fontSize: 20.0, color: lightGray),
              decoration: InputDecoration(
                errorStyle: TextStyle(color: red, fontSize: 12.0),
                isDense: true,
                // Disable all the underlines of input field.
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
