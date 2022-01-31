import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/comment.dart';
import 'package:test_app_for_eclipse_ds/repositories/comment_repositories/base_comment_repository.dart';

part 'comment_state.dart';
part 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final BaseCommentRepository _commentRepository;
  CommentBloc(this._commentRepository) : super(CommentsLoading()) {
    on<LoadComments>(getComments);
    on<PostComment>(getComments);
  }

  Future<void> getComments(
      CommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentsLoading());
    try {
      if (event is LoadComments) {
        List<Comment> response = _commentRepository.getCommentsFromCache(event.postId);
        if (response.isEmpty) {
          response =
              (await _commentRepository.getCommentsFromServer(event.postId))
                  .map(
                    (e) => Comment.fromJson(e),
              )
                  .toList();
          await commentBox!.addAll(response);
        }
        emit(CommentsLoaded(comments: response));
      }
      if (event is PostComment) {
        List<Comment> response = _commentRepository.getCommentsFromCache(event.postId);
        if (response.isEmpty) {
          response =
              (await _commentRepository.getCommentsFromServer(event.postId))
                  .map(
                    (e) => Comment.fromJson(e),
              )
                  .toList();
        }
        final List<Comment> response2 = (await _commentRepository.postCommentToServer(
                event.postId, event.name, event.email, event.body))
            .map((e) => Comment.fromJson(e))
            .toList();
        response.addAll(response2);
        await commentBox!.addAll(response2);
        emit(CommentsLoaded(comments: response));
      }
    } catch (err) {
      emit(
        CommentsError(message: err.toString()),
      );
    }
  }
}
