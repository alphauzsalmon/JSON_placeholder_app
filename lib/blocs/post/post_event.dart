part of 'post_bloc.dart';

abstract class PostEvent {
  const PostEvent();
}

class LoadPosts extends PostEvent {
  final int userId;
  const LoadPosts(this.userId);
}