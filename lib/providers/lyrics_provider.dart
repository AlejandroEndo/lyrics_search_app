import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_search_app/api/lyrics_api.dart';
import 'package:lyrics_search_app/models/song.dart';
import 'package:lyrics_search_app/pages/lyrics_page.dart';
import 'package:lyrics_search_app/widgets/error_result.dart';

class LyricsProvider with ChangeNotifier {
  final _api = LyricsApi();
  List<Song> songs = [];
  List<String> suggestions = [];

  Future<void> getLyrics(
      BuildContext context, String artist, String song) async {
    int index = songs
        .indexWhere((_song) => _song.artist == artist && _song.title == song);
    if (index != -1) {
      print('previous search fineded.');
      final removedSong = songs.removeAt(index);
      songs.insert(0, removedSong);
    } else {
      print('doing new search');
      final Map<String, dynamic> result = await _api.getLyrics(artist, song);

      if (result['error'] == null) {
        if (result['lyrics'].isEmpty)
          return showDialog(
            context: context,
            builder: (context) =>
                ErrorResult(message: 'Song lyrics can\'t be found'),
          );

        final newSong =
            Song(artist: artist, title: song, lyrics: result['lyrics']);
        songs.insert(0, newSong);
        print('opening song');
        openSong(context, songs[0]);
        notifyListeners();
      } else {
        return showDialog(
          context: context,
          builder: (context) => ErrorResult(message: result['error']),
        );
      }
    }
  }

  Future<void> getSuggestionsByArtist(String artist) async {
    suggestions.clear();
    try {
      List result = await _api.getSuggestions(artist);
      for (int i = 0; i < result.length; i++) {
        if (result[i]['artist']['name'].toLowerCase() == artist) {
          print(result[i]['title']);
          suggestions.add(result[i]['title']);
        }
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearHistory() {
    songs.clear();
    notifyListeners();
    return null;
  }

  Future<void> openSong(BuildContext context, Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LyricsPage(song: song)),
    );
    return null;
  }
}
