import 'dart:io';

import 'package:proplaya_communication/proplaya_communication.dart';
import 'package:proplaya_storage_management/proplaya_storage_management.dart';

enum SourcePlatforms {
  youtube,
}

abstract class Entity extends Serializable {
  final SourcePlatforms sourcePlatform;

  Entity({
    required this.sourcePlatform,
    required super.id,
    required super.url,
    super.downloaded,
    super.children,
  });

  // Dear future me, This YoutubeMusicCommunicator closes the YoutubeExplode instance after downloading the audio. So if you decide to pass an existing instance of YoutubeExplode to the communicator, this the issue.
  Communicator get communicator => switch (sourcePlatform) {
        SourcePlatforms.youtube => YoutubeMusicCommunicator(),
      };

  @override
  Future<File?>? download(String pathWithName) => switch (runtimeType) {
        SongE => communicator.download(pathWithName, this as SongE),
        PlaylistE => null,
        _ => null,
      };
}
