import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lyrics_search_app/pages/home_page.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';
import 'package:lyrics_search_app/pages/previous_search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provider initial config
      builder: (context) => LyricsProvider(),
      child: MaterialApp(
        title: 'Lyrics ovh',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'previousSearch': (context) => PreviousSearchPage(),
        },
      ),
    );
  }
}
