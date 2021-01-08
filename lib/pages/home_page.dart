import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:lyrics_search_app/constants.dart';
import 'package:lyrics_search_app/widgets/artist_input_field.dart';
import 'package:lyrics_search_app/widgets/icon_action_button.dart';
import 'package:lyrics_search_app/widgets/search_button.dart';
import 'package:lyrics_search_app/widgets/song_input_field.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';
import 'package:lyrics_search_app/widgets/song_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text form Key
  final _formKey = GlobalKey<FormState>();
  // Text input controllers
  final _artistCtrl = TextEditingController();
  final _songCtrl = TextEditingController();

  // circular loading indicator for search button
  bool _loading = false;

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
          'Lyrics.ovh',
          style: TextStyle(
            color: white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Go to Previous searchs page
          IconActionButton(
            icon: Icons.history,
            onPressed: () => Navigator.pushNamed(context, 'previousSearch'),
          ),
        ],
      ),
      body: GestureDetector(
        // Click anywhere to close keyboard
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.height * 0.80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.library_music, color: pink, size: size.width * 0.3),
                // Search form
                _searchForm(provider),
                // Show last search
                provider.songs.isEmpty
                    ? Container()
                    : SongTile(song: provider.songs[0]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Search form build.
  Widget _searchForm(LyricsProvider provider) => Form(
        key: _formKey,
        child: Column(
          children: [
            ArtistInputField(
              controller: _artistCtrl,
              onChanged: (value) {
                if (_loading) _loading = false;
              },
              validator: (value) => value.isEmpty ? EMPTY_FIELD_ERROR : null,
            ),
            SizedBox(height: 20.0),
            SongInputText(
              controller: _songCtrl,
              onSubmitted: (_) => _search(provider),
              onTap: () async {
                // Search suggestions using the artist name
                await provider.getSuggestionsByArtist(_artistCtrl.text);
              },
              validator: (value) => value.isEmpty ? EMPTY_FIELD_ERROR : null,
            ),
            SizedBox(height: 20.0),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                    // Set the color of circular progress indicator
                    valueColor: AlwaysStoppedAnimation<Color>(white),
                  ))
                : SearchButton(onPressed: () async => _search(provider)),
            SizedBox(height: 15.0),
          ],
        ),
      );

  // Search Lyrics
  void _search(provider) async {
    // Close keyboard.
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      // Start circular progress indicator.
      setState(() => _loading = true);
      // Start search.
      await provider.getLyrics(context, _artistCtrl.text.toLowerCase(),
          _songCtrl.text.toLowerCase());
      // Clean input fields.
      _artistCtrl.clear();
      _songCtrl.clear();
      // End circular progress indicator.
      setState(() => _loading = false);
    }
  }
}
