import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'package:lyrics_search_app/models/song.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';
import 'package:lyrics_search_app/widgets/song_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  Song _song;

  FocusNode _artistNode;
  FocusNode _titleNode;
  final _artistCtrl = TextEditingController();
  // final _songCtrl = TextEditingController();

  // TESTING
  final TextEditingController _songCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _artistNode = FocusNode();
    _titleNode = FocusNode();
  }

  @override
  void dispose() {
    _artistNode.dispose();
    _titleNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LyricsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search lyrics'),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pushNamed(context, 'previousSearch'),
            child: Text('History'),
          )
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _artistCtrl,
                focusNode: _artistNode,
                onChanged: (value) {
                  if (_loading) _loading = false;
                },
                validator: (value) {
                  if (value.isEmpty) return 'this field must not be empty';
                  return null;
                },
                textInputAction: TextInputAction.done,
              ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _songCtrl,
                  decoration: InputDecoration(labelText: 'Select a User'),
                  focusNode: _titleNode,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _search(provider),
                  onTap: () async {
                    await provider.getSuggestionsByArtist(_artistCtrl.text);
                  },
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
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  _songCtrl.text = suggestion;
                },
                validator: (val) =>
                    val.isEmpty ? 'Please select a user...' : null,
              ),
              // TextFormField(
              //   controller: _songCtrl,
              //   onChanged: (value) {
              //     if (_loading) _loading = false;
              //   },
              //   validator: (value) {
              //     if (value.isEmpty) return 'this field must not be empty';
              //     return null;
              //   },
              //   textInputAction: TextInputAction.done,
              //   focusNode: _titleNode,
              //   onFieldSubmitted: (_) async => _search(provider),
              // ),
              _loading
                  ? Center(child: CircularProgressIndicator())
                  : MaterialButton(
                      onPressed: () async => _search(provider),
                      child: Text('Search'),
                    ),
              provider.songs.isEmpty
                  ? Container()
                  : SongTile(song: provider.songs[0]),
            ],
          ),
        ),
      ),
    );
  }

  void _search(provider) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      setState(() => _loading = true);
      await provider.getLyrics(context, _artistCtrl.text, _songCtrl.text);
      _artistCtrl.clear();
      _songCtrl.clear();
      setState(() => _loading = false);
    }
  }
}
