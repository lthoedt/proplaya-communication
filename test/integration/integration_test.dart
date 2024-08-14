import 'package:proplaya_communication/src/communicators/entities/entity.dart';
import 'package:proplaya_communication/src/communicators/entities/playlist_e.dart';
import 'package:proplaya_communication/src/communicators/entities/song_e.dart';
import 'package:proplaya_downloader/proplaya_downloader.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Integration', () {
    final downloader = ProplayaDownloader();

    setUpAll(() async {
      const MethodChannel channel =
          MethodChannel('plugins.flutter.io/path_provider');
      TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        return "build/storage/";
      });
      // Background workers dont work in tests.
      // await downloader.init();
    });

    group("Downloading", () {
      group("Playlists", () {
        final List<PlaylistE> playlists = [
          PlaylistE(
            id: "PLnCpIJcIBB-GFM-ineMerfYGrRTnDOayj",
            name: "Awesome Mix Vol. 1",
            length: 1,
            url: "https://www.youtube.com/playlist?list=abd",
            sourcePlatform: SourcePlatforms.youtube,
            children: [
              SongE(
                id: "7Z3uhIRkBNw",
                name: "Hooked on a Feeling",
                url: "https://www.youtube.com/watch?v=7Z3uhIRkBNw",
                sourcePlatform: SourcePlatforms.youtube,
              ),
            ],
          ),
        ];

        setUpAll(() async {
          // Add playlists to the queue as you would in the app.
          print('Adding playlists to the queue...');
          playlists.forEach(downloader.download);
        });

        test("Emulating background worker", () async {
          // Handle the queue thereby emulating the background service.
          await downloader.handleQueue_();
        });
      });
    });
  });
}
