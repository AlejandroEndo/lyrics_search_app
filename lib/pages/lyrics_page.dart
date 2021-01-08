import 'package:flutter/material.dart';
import 'package:lyrics_search_app/constants.dart';
import 'package:lyrics_search_app/models/song.dart';

class LyricsPage extends StatelessWidget {
  const LyricsPage({Key key, @required this.song}) : super(key: key);
  final Song song;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: gray,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: lightGray,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Song title
            Text(song.title,
                style: TextStyle(
                    color: white, fontSize: 20.0, fontWeight: FontWeight.bold)),
            // Song artist
            Text(song.artist,
                style: TextStyle(
                    color: pink, fontSize: 15.0, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: size.width * 0.03,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: 30.0,
          ),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: pink.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 10.0,
              ),
            ],
          ),
          // song lyrics
          child: Text(
            song.lyrics,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: lightGray,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
