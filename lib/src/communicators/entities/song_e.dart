import 'package:proplaya_communication/src/communicators/entities/entity.dart';
import 'package:proplaya_storage_management/proplaya_storage_management.dart';

class SongE extends Entity {
  final String name;

  @override
  StorageTypes get type => StorageTypes.song;

  SongE({
    required this.name,
    required super.id,
    required super.url,
    required super.sourcePlatform,
    super.downloaded,
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'name': name,
      };
}
