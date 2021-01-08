import 'dart:convert';

import 'package:http/http.dart' as http;

class LyricsApi {
  Future<Map<String, dynamic>> getLyrics(String artist, String song) async {
    print('https://api.lyrics.ovh/v1/$artist/$song');
    try {
      var response = await http.get('https://api.lyrics.ovh/v1/$artist/$song');
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return result;
    } catch (e) {}
  }
}
