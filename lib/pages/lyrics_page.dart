import 'package:flutter/material.dart';
import 'package:lyrics_search_app/models/song.dart';

class LyricsPage extends StatelessWidget {
  const LyricsPage({Key key, @required this.song}) : super(key: key);
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(song.title),
            Text(song.artist),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Text(song.lyrics),
      ),
    );
  }
}
