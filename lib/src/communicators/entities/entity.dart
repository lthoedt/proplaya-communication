import 'package:proplaya_communication/proplaya_communication.dart';
import 'package:proplaya_storage_management/proplaya_storage_management.dart';

enum SourcePlatforms {
  youtube,
}

abstract class Entity<T> extends Serializable<T> {
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
}
