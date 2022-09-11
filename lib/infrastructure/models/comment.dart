import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 7)
class Comment extends Equatable {
  const Comment({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "name": name,
        "email": email,
        "body": body,
      };

  @override
  List<Object?> get props => [
        postId,
        id,
        name,
        email,
        body,
      ];
}

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  Comment read(BinaryReader reader) {
    return Comment(
      postId: reader.read(),
      id: reader.read(),
      name: reader.read(),
      email: reader.read(),
      body: reader.read(),
    );
  }

  @override
  final typeId = 7;

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..write(obj.postId)
      ..write(obj.id)
      ..write(obj.name)
      ..write(obj.email)
      ..write(obj.body);
  }
}
