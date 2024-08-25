import 'package:proplaya_communication/proplaya_communication.dart';
import 'package:proplaya_communication/src/mappers/entity_mapper.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeMusicMapper implements EntityMapper<Video, Playlist> {
  @override
  SongE toSong(song) => SongE(
        id: song.id.value,
        name: song.title,
        artist: song.author,
        duration: song.duration,
        url: song.url,
        sourcePlatform: SourcePlatforms.youtube,
      );

  @override
  PlaylistE toPlaylist(playlist) => PlaylistE(
        id: playlist.id.value,
        name: playlist.title,
        length: playlist.videoCount ?? -1,
        downloaded: null,
        url: playlist.url,
        sourcePlatform: SourcePlatforms.youtube,
      );
}
