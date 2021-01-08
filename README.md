# lyrics_search_app

A lyrics search app using e https://lyricsovh.docs.apiary.io/ API

## Features

1. Search: a screen with a form consisting of two text inputs: ‘artist’ and ‘song title’.
After filling both inputs and submitting, a screen containing the song lyrics must
be presented.
Lyrics must be retrieved from the https://lyricsovh.docs.apiary.io/ Rest API.
An appropriate error message should be displayed if the lyrics can’t be retrieved
for whatever reason.
Below the search form, include a ‘Previous search’ section showing the artist and
song title of the last lyrics that has been successfully retrieved after a search
(only if there was a previous successful search). This section must only show 1
item, the user must be able to tap on it to see the lyrics on a new screen.

2. History: a screen listing the previously retrieved songs. The user must be able to
tap on any song to see its lyrics on a new screen.

## Run

- Connect your phone with usb cable
- with flutter previously installed on your computer, navigate to the folder where the project is.
- Type the command flutter run.
