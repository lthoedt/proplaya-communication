// This is the interface of the communicators. It is used to define the methods that all communicators must implement.
// When adapting for a new service like Spotify, it needs to extend from this.
import 'dart:io';

import 'package:proplaya_communication/src/communicators/entities/playlist_e.dart';
import 'package:proplaya_communication/src/communicators/entities/song_e.dart';

mixin Communicator {
  Future<PlaylistE?> getPlaylist(String playlistId) async {
    try {
      return await getPlaylist_(playlistId);
    } catch (e) {
      return null;
    }
  }

  Future<PlaylistE> getPlaylist_(String playlistId);

  Future<File?> download(String path, SongE songE);
}
