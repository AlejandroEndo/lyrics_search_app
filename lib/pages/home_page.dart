import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lyrics_search_app/models/song.dart';
import 'package:lyrics_search_app/providers/lyrics_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  Song _song;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LyricsProvider>(context);
    final _artistCtrl = TextEditingController();
    final _songCtrl = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _artistCtrl,
                validator: (value) {
                  if (value.isEmpty) return 'this field must not be empty';
                  return null;
                },
              ),
              TextFormField(
                controller: _songCtrl,
                validator: (value) {
                  if (value.isEmpty) return 'this field must not be empty';
                  return null;
                },
              ),
              _loading
                  ? Center(child: CircularProgressIndicator())
                  : MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => _loading = true);
                          await provider.getLyrics(
                              context, _artistCtrl.text, _songCtrl.text);
                          setState(() => _loading = false);
                        }
                      },
                      child: Text('Search'),
                    ),
              provider.songs.isEmpty
                  ? Container()
                  : ListTile(
                      title: Text(provider.songs[0].title ?? ''),
                      subtitle: Text(provider.songs[0].artist ?? ''),
                      onTap: () =>
                          provider.openSong(context, provider.songs[0]),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
