import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:lyrics_search_app/constants.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';

class SongInputText extends StatelessWidget {
  SongInputText({
    Key key,
    @required this.controller,
    @required this.validator,
    @required this.onSubmitted,
    @required this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String value) validator;
  final Function(String value) onSubmitted;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<LyricsProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Song Title:',
            style: TextStyle(
              fontSize: 15.0,
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 9.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: controller,
                style: TextStyle(fontSize: 20.0, color: lightGray),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: red, fontSize: 12.0),
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                // focusNode: _titleNode,
                textInputAction: TextInputAction.done,
                onSubmitted: onSubmitted,
                onTap: onTap,
              ),
              suggestionsCallback: (pattern) {
                List<String> matches = List();
                matches.addAll(provider.suggestions);
                matches.retainWhere(
                    (s) => s.toLowerCase().contains(pattern.toLowerCase()));
                return matches;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  tileColor: white,
                  title: Text(
                    suggestion,
                    style: TextStyle(color: lightGray, fontSize: 15.0),
                  ),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                controller.text = suggestion;
              },
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
