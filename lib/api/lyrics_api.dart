import 'dart:convert';

import 'package:http/http.dart' as http;

class LyricsApi {
  Future<Map<String, dynamic>> getLyrics(String artist, String song) async {
    try {
      print('calling api, ARTIST: $artist, SONG: $song');
      var response = await http.get('https://api.lyrics.ovh/v1/$artist/$song');
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return result;
    } catch (e) {
      return {
        'error':
            'Something went wrong, check your internet conection and try again later.'
      };
    }
  }

  Future<List> getSuggestions(String artist) async {
    try {
      print('calling suggest');
      var response = await http.get('https://api.lyrics.ovh/suggest/$artist');
      Map<String, dynamic> result = json.decode(response.body);
      return result['data'];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
