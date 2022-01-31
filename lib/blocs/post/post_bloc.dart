import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/post.dart';
import 'package:test_app_for_eclipse_ds/repositories/post_repositories/base_post_repository.dart';

part 'post_state.dart';
part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final BasePostRepository _postRepository;
  PostBloc(this._postRepository) : super(PostsLoading()) {
    on<LoadPosts>(getPosts);
  }

  Future<void> getPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(PostsLoading());
      try {
        List<Post> response = _postRepository.getPostsFromCache(event.userId);
        if (response.isEmpty) {
          response =
              (await _postRepository.getPostsFromServer(event.userId))
                  .map((e) => Post.fromJson(e))
                  .toList();
          await postBox!.addAll(response);
          emit(PostsLoaded(posts: response));
        }
        else {
          emit(PostsLoaded(posts: response));
        }
      } catch (err) {
        emit(
          PostsError(message: err.toString()),
        );
      }
  }
}
