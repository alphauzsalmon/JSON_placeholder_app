import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class Album extends Equatable {
  const Album({
    this.userId,
    this.id,
    this.title,
  });

  final int? userId;
  final int? id;
  final String? title;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
      ];
}

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  Album read(BinaryReader reader) {
    return Album(
      userId: reader.read(),
      id: reader.read(),
      title: reader.read(),
    );
  }

  @override
  final typeId = 5;

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..write(obj.userId)
      ..write(obj.id)
      ..write(obj.title);
  }
}
