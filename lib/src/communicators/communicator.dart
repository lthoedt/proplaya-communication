// This is the interface of the communicators. It is used to define the methods that all communicators must implement.
// When adapting for a new service like Spotify, it needs to extend from this.
import 'dart:io';

import 'package:proplaya_communication/src/communicators/entities/playlist_e.dart';
import 'package:proplaya_communication/src/communicators/entities/song_e.dart';
import 'package:proplaya_communication/src/mappers/entity_mapper.dart';

abstract class Communicator<Song, Playlist> {
  final EntityMapper<Song, Playlist> mapper;

  Communicator({required this.mapper});

  Future<PlaylistE?> getPlaylist(String playlistId) async {
    try {
      return mapper.toPlaylist(await getPlaylist_(playlistId));
    } catch (e) {
      return null;
    }
  }

  Future<List<SongE>?> getSongsOfPlaylist(String playlistId) async {
    try {
      return (await getSongsOfPlaylist_(playlistId))
          .map((e) => mapper.toSong(e))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<Playlist> getPlaylist_(String playlistId);
  Future<Iterable<Song>> getSongsOfPlaylist_(String playlistId);

  Future<File> download(String path, SongE songE);
}
