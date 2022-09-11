import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/post.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/post_repositories/base_post_repository.dart';

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
      List<Post> posts = await _postRepository.getPosts(event.userId);
      emit(PostsLoaded(posts: posts));
    } catch (err) {
      emit(
        PostsError(message: err.toString()),
      );
    }
  }
}
