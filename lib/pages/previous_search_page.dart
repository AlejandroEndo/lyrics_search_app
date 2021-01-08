import 'package:flutter/material.dart';
import 'package:lyrics_search_app/constants.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';
import 'package:lyrics_search_app/widgets/icon_action_button.dart';
import 'package:lyrics_search_app/widgets/song_tile.dart';
import 'package:provider/provider.dart';

class PreviousSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LyricsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightGray,
        elevation: 1,
        title: Text('History'),
        actions: [
          IconActionButton(
            icon: Icons.delete_forever,
            onPressed: () => provider.clearHistory(),
          ),
        ],
      ),
      backgroundColor: gray,
      body: ListView.builder(
        itemCount: provider.songs?.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(top: 15.0),
          child: SongTile(
            song: provider.songs[index],
          ),
        ),
      ),
    );
  }
}
