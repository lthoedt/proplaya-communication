import 'package:proplaya_communication/src/communicators/communicator.dart';
import 'package:proplaya_communication/src/communicators/entities/playlist_e.dart';
import 'package:proplaya_communication/src/communicators/youtube_music_communicator.dart';
import 'package:test/test.dart';

void main() {
  group('Communicator', () {
    final List<Communicator> communicators = [
      YoutubeMusicCommunicator(),
    ];

    setUp(() {
      // Additional setup goes here.
      print('Setting up...');
    });

    for (var communicator in communicators) {
      print('Testing ${communicator.runtimeType}...');

      const String playlistId = "PLnCpIJcIBB-GFM-ineMerfYGrRTnDOayj";

      group("Playlists", () {
        group("Get", () {
          test('Success', () async {
            final PlaylistE? playlistE =
                await communicator.getPlaylist(playlistId);
            expect(playlistE, isNotNull);
            print(playlistE!.name);
            expect(playlistE.id, playlistId);
          });

          test('Not found', () async {
            final PlaylistE? playlistE = await communicator.getPlaylist("");
            expect(playlistE, isNull);
          });
        });
      });
    }
  });
}
