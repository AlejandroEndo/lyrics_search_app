import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lyrics_search_app/constants.dart';
import 'package:lyrics_search_app/widgets/artist_input_field.dart';
import 'package:lyrics_search_app/widgets/search_button.dart';
import 'package:lyrics_search_app/widgets/song_input_field.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: gray,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: lightGray,
        title: Text(
          'lyrics.ovh',
          style: TextStyle(
            color: white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.history,
              color: pink,
            ),
            onPressed: () => Navigator.pushNamed(context, 'previousSearch'),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Container(
                height: size.height * 0.80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.library_music,
                      color: pink,
                      size: size.width * 0.3,
                    ),
                    Column(
                      children: [
                        ArtistInputField(
                          controller: _artistCtrl,
                          onChanged: (value) {
                            if (_loading) _loading = false;
                          },
                          validator: (value) =>
                              value.isEmpty ? EMPTY_FIELD_ERROR : null,
                        ),
                        SizedBox(height: 20.0),
                        SongInputText(
                          controller: _songCtrl,
                          onSubmitted: (_) => _search(provider),
                          onTap: () async {
                            await provider
                                .getSuggestionsByArtist(_artistCtrl.text);
                          },
                          validator: (value) =>
                              value.isEmpty ? EMPTY_FIELD_ERROR : null,
                        ),
                        SizedBox(height: 20.0),
                        _loading
                            ? Center(
                                child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(white),
                              ))
                            : SearchButton(
                                onPressed: () async => _search(provider)),
                        SizedBox(height: 15.0),
                      ],
                    ),
                    provider.songs.isEmpty
                        ? Container()
                        : SongTile(song: provider.songs[0]),
                  ],
                ),
              ),
            ),
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
