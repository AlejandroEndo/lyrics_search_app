import 'package:flutter/material.dart';
import 'package:lyrics_search_app/models/song.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';
import 'package:provider/provider.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({Key key, @required this.song}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title ?? ''),
      subtitle: Text(song.artist ?? ''),
      onTap: () {
        final provider = Provider.of<LyricsProvider>(context, listen: false);
        provider.openSong(context, song);
      },
    );
  }
}
