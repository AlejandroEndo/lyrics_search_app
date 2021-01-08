import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:lyrics_search_app/constants.dart';

class LyricsApi {
  // Calling for lyrics by song title and artist.
  Future<Map<String, dynamic>> getLyrics(String artist, String song) async {
    try {
      var response = await http.get('https://api.lyrics.ovh/v1/$artist/$song');
      Map<String, dynamic> result = json.decode(response.body);
      return result;
    } catch (e) {
      return {'error': CONECTION_ERROR};
    }
  }

  // Calling songs suggestions by artist.
  Future<List> getSuggestions(String artist) async {
    try {
      var response = await http.get('https://api.lyrics.ovh/suggest/$artist');
      Map<String, dynamic> result = json.decode(response.body);
      return result['data'];
    } catch (e) {
      return [];
    }
  }
}
