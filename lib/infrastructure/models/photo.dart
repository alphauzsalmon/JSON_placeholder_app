import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 6)
class Photo extends Equatable {
  const Photo({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  @override
  List<Object?> get props => [
        albumId,
        id,
        title,
        url,
        thumbnailUrl,
      ];
}

class PhotoAdapter extends TypeAdapter<Photo> {
  @override
  Photo read(BinaryReader reader) {
    return Photo(
      albumId: reader.read(),
      id: reader.read(),
      title: reader.read(),
      url: reader.read(),
      thumbnailUrl: reader.read(),
    );
  }

  @override
  final typeId = 6;

  @override
  void write(BinaryWriter writer, Photo obj) {
    writer
      ..write(obj.albumId)
      ..write(obj.id)
      ..write(obj.title)
      ..write(obj.url)
      ..write(obj.thumbnailUrl);
  }
}
