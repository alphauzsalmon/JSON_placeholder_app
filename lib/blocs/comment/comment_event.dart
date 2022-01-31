part of 'comment_bloc.dart';

abstract class CommentEvent {
  const CommentEvent();
}

class LoadComments extends CommentEvent {
  final int postId;
  const LoadComments(this.postId);
}

class PostComment extends CommentEvent {
  final int postId;
  final String name;
  final String email;
  final String body;

  const PostComment({
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });
}
