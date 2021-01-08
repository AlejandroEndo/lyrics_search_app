import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_search_app/api/lyrics_api.dart';
import 'package:lyrics_search_app/constants.dart';
import 'package:lyrics_search_app/models/song.dart';
import 'package:lyrics_search_app/pages/lyrics_page.dart';
import 'package:lyrics_search_app/widgets/error_result.dart';

class LyricsProvider with ChangeNotifier {
  final _api = LyricsApi();
  List<Song> _songs = [];
  List<Song> get songs => _songs;
  List<String> _suggestions = [];
  List<String> get suggestions => _suggestions;

  Future<void> getLyrics(
      BuildContext context, String artist, String song) async {
    // Check if the lyrics was previously searched.
    int index = _songs
        .indexWhere((_song) => _song.artist == artist && _song.title == song);

    if (index != -1) {
      // If lyrics was previously searched, move it to the start.
      final removedSong = _songs.removeAt(index);
      _songs.insert(0, removedSong);
      openSong(context, _songs[0]);
      notifyListeners();
    } else {
      // If song was never searched, call to the API.
      final Map<String, dynamic> result = await _api.getLyrics(artist, song);

      // Check if the API call could be made.
      if (result['error'] == null) {
        // Lyrics not found.
        if (result['lyrics'].isEmpty)
          return showDialog(
            context: context,
            builder: (context) => ErrorResult(message: NOT_FOUND_ERROR),
          );
        // Add result to search history.
        final newSong =
            Song(artist: artist, title: song, lyrics: result['lyrics']);
        _songs.insert(0, newSong);
        openSong(context, _songs[0]);
        notifyListeners();
      } else {
        // If can not connect to the API...
        return showDialog(
          context: context,
          builder: (context) => ErrorResult(message: result['error']),
        );
      }
    }
  }

  // Songs suggestions by artist name.
  Future<void> getSuggestionsByArtist(String artist) async {
    _suggestions.clear();
    try {
      List result = await _api.getSuggestions(artist);
      for (int i = 0; i < result.length; i++) {
        if (result[i]['artist']['name'].toLowerCase() == artist) {
          print(result[i]['title']);
          _suggestions.add(result[i]['title']);
        }
      }
      notifyListeners();
    } catch (e) {}
  }

  // Clear the search history
  Future<void> clearHistory() {
    _songs.clear();
    notifyListeners();
    return null;
  }

  // Open song lyrics
  Future<void> openSong(BuildContext context, Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LyricsPage(song: song)),
    );
    return null;
  }
}
