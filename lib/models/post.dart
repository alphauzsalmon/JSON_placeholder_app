import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class Post extends Equatable {
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  @HiveField(0)
  int? userId;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        body,
      ];
}

class PostAdapter extends TypeAdapter<Post> {
  @override
  Post read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Post(
      userId: fields[0] as int,
      id: fields[1] as int,
      title: fields[2] as String,
      body: fields[3] as String,
    );
  }

  @override
  final typeId = 4;

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.body);
  }
}
