import 'package:proplaya_communication/proplaya_communication.dart';
import 'package:proplaya_storage_management/proplaya_storage_management.dart';

class PlaylistE extends Entity {
  final String name;
  final int length;

  @override
  StorageTypes get type => StorageTypes.playlist;

  PlaylistE({
    required this.name,
    required this.length,
    required super.id,
    required super.url,
    required super.sourcePlatform,
    super.downloaded,
    super.children,
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'name': name,
        'length': length,
      };

  @override
  Future<List<SongE>?>? getChildren_(String id) =>
      communicator.getSongsOfPlaylist(id);
}
