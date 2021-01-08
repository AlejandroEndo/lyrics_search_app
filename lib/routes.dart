import 'package:flutter/material.dart';
import 'package:lyrics_search_app/pages/home_page.dart';

final Map<String, WidgetBuilder> routes = {
  'home': (BuildContext context) => HomePage(),
  'lyrics': (BuildContext context) => HomePage(),
  'previousSearch': (BuildContext context) => HomePage(),
};
