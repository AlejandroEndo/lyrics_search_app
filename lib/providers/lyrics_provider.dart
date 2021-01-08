import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_search_app/api/lyrics_api.dart';
import 'package:lyrics_search_app/models/song.dart';
import 'package:lyrics_search_app/pages/lyrics_page.dart';
import 'package:lyrics_search_app/widgets/error_result.dart';

class LyricsProvider with ChangeNotifier {
  final _api = LyricsApi();
  List<Song> songs = [];

  Future<void> getLyrics(
      BuildContext context, String artist, String song) async {
    int index = songs
        .indexWhere((_song) => _song.artist == artist && _song.title == song);
    if (index != -1) {
      final removedSong = songs.removeAt(index);
      songs.insert(0, removedSong);
    } else {
      final Map<String, dynamic> result = await _api.getLyrics(artist, song);

      if (result['lyrics'].isEmpty)
        return showDialog(
          context: context,
          builder: (context) => ErrorResult(),
        );

      final newSong =
          Song(artist: artist, title: song, lyrics: result['lyrics']);
      songs.insert(0, newSong);
    }

    openSong(context, songs[0]);
    notifyListeners();
  }

  Future<void> clearHistory() {
    songs.clear();
    notifyListeners();
  }

  Future<void> openSong(BuildContext context, Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LyricsPage(song: song)),
    );
    return null;
  }
}
