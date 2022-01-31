part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

class CommentsLoading extends CommentState {}

class CommentsLoaded extends CommentState {
  final List<Comment> comments;

  const CommentsLoaded({this.comments = const <Comment>[]});

  @override
  List<Object?> get props => [comments];
}

class CommentsError extends CommentState {
  final String message;
  const CommentsError({required this.message});
}