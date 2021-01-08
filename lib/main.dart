import 'package:flutter/material.dart';
import 'package:lyrics_search_app/pages/home_page.dart';
import 'package:lyrics_search_app/pages/previous_search_page.dart';
import 'package:provider/provider.dart';

import 'package:lyrics_search_app/providers/lyrics_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => LyricsProvider(),
      child: MaterialApp(
        title: 'Lyrics search',
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'previousSearch': (context) => PreviousSearchPage(),
        },
      ),
    );
  }
}
