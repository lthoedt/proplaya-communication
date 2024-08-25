import 'dart:io';

// import 'package:just_audio/just_audio.dart';
import 'package:duration_logger/duration_logger.dart';
import 'package:filesize/filesize.dart';
import 'package:proplaya_communication/src/communicators/communicator.dart';
import 'package:proplaya_communication/src/communicators/entities/song_e.dart';
import 'package:proplaya_communication/src/mappers/youtube_music_mapper.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as p;

class YoutubeMusicCommunicator extends Communicator<Video, Playlist> {
  late final YoutubeExplode yt;

  YoutubeMusicCommunicator()
      : super(
          mapper: YoutubeMusicMapper(),
        ) {
    yt = YoutubeExplode();
  }

  /// Downloads the audio of a song.
  @override
  Future<File> download(
    String pathWithName,
    SongE song,
  ) async {
    final logger = DurationLogger(keepLogs: true);

    final String songId = song.id;

    final StreamManifest manifest = await yt.videos.streamsClient
        .getManifest(songId)
        .logTime("Getting manifest", logger);

    final StreamInfo streamInfo = manifest.audioOnly.withHighestBitrate();

    final Stream stream = yt.videos.streamsClient.get(streamInfo);

    // [Downloading audio to a file]
    // Open a file for writing.
    final file = File(
      p.setExtension(
        pathWithName,
        ".${streamInfo.codec.subtype}",
      ),
    );
    await file.create(recursive: true);

    final fileStream = file.openWrite();

    // Pipe all the content of the stream into the file.
    await stream.pipe(fileStream).logTime("Downloading song", logger);

    file.stat().then((stat) {
      logger.done();
      print(
        "Getting manifest took ${logger.getDurationOfAction("Getting manifest")!.inMilliseconds} ms",
      );

      final duration = logger.getDurationOfAction("Downloading song")!;

      print(
        "Downloaded '$songId' ${filesize(stat.size)} at ${(filesize((stat.size / duration.inMilliseconds * 1000).toInt()))}/s",
      );
    });

    // Close the file.
    await fileStream.flush();
    await fileStream.close();
    yt.close();

    return file;
  }

  // [Playing audio from a file]
  //
  // final player = AudioPlayer();

  // final duration = await player.setFilePath(file.path);

  // player.play();

  @override
  Future<Playlist> getPlaylist_(String playlistId) =>
      yt.playlists.get(playlistId);

  @override
  Future<Iterable<Video>> getSongsOfPlaylist_(String playlistId) =>
      yt.playlists.getVideos(playlistId).toList();
}
