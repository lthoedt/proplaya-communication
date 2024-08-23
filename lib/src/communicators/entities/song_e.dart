import 'dart:io';

import 'package:proplaya_communication/src/communicators/entities/entity.dart';
import 'package:proplaya_storage_management/proplaya_storage_management.dart';

class SongE extends Entity {
  final String name;
  final Duration? duration;
  final String artist;

  @override
  StorageTypes get type => StorageTypes.song;

  SongE({
    required this.name,
    required this.duration,
    required this.artist,
    required super.id,
    required super.url,
    required super.sourcePlatform,
    super.downloaded,
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'name': name,
        'duration': duration?.inMilliseconds,
        'artist': artist,
      };

  @override
  Future<List?>? getChildren_(String id, {bool force = false}) => null;

  @override
  Future<File?>? download(String pathWithName) =>
      communicator.download(pathWithName, this);
}
