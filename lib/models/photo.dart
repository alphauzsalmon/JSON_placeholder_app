import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 6)
class Photo extends Equatable {
  Photo({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };

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
