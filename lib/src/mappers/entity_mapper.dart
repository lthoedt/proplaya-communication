import 'package:proplaya_communication/proplaya_communication.dart';

abstract class EntityMapper<Song, Playlist> {
  SongE toSong(Song song);
  PlaylistE toPlaylist(Playlist playlist);
}
