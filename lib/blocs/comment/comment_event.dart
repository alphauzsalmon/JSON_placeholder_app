part of 'comment_bloc.dart';

abstract class CommentEvent {
  const CommentEvent();
}

class LoadComments extends CommentEvent {
  final int postId;
  const LoadComments(this.postId);
}

class PostComment extends CommentEvent {
  final Comment comment;

  const PostComment({required this.comment});
}
