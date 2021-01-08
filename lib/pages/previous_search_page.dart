import 'package:flutter/material.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';
import 'package:lyrics_search_app/widgets/song_tile.dart';
import 'package:provider/provider.dart';

class PreviousSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LyricsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          MaterialButton(
            onPressed: () => provider.clearHistory(),
            child: Text('Clear'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: provider.songs?.length,
        itemBuilder: (context, index) => SongTile(
          song: provider.songs[index],
        ),
      ),
    );
  }
}
