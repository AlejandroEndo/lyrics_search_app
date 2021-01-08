import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lyrics_search_app/constants.dart';
import 'package:lyrics_search_app/models/song.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({Key key, @required this.song}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Previous view of searched songs.
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Material(
        color: lightGray,
        borderRadius: BorderRadius.circular(10.0),
        child: ListTile(
          // Default icon.
          leading: Icon(Icons.queue_music, color: pink, size: 50.0),
          trailing: Icon(Icons.arrow_right, color: white),
          // Song title
          title: Text(
            song.title,
            style: TextStyle(
                fontSize: 15.0, color: white, fontWeight: FontWeight.bold),
          ),
          // Song artist
          subtitle: Text(
            song.artist,
            style: TextStyle(
                fontSize: 12.0, color: white, fontWeight: FontWeight.w500),
          ),
          onTap: () {
            final provider =
                Provider.of<LyricsProvider>(context, listen: false);
            provider.openSong(context, song);
          },
        ),
      ),
    );
  }
}
