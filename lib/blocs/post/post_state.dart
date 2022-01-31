part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostsLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> posts;

  const PostsLoaded({this.posts = const <Post>[]});

  @override
  List<Object?> get props => [posts];
}

class PostsError extends PostState {
  final String message;
  const PostsError({required this.message});
}