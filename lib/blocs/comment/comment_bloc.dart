import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/comment.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/comment_repositories/base_comment_repository.dart';

part 'comment_state.dart';
part 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final BaseCommentRepository _commentRepository;
  CommentBloc(this._commentRepository) : super(CommentsLoading()) {
    on<LoadComments>(getComments);
    on<PostComment>(postComment);
  }

  Future<void> getComments(
      LoadComments event, Emitter<CommentState> emit) async {
    emit(CommentsLoading());
    try {
      final List<Comment> response =
          await _commentRepository.getComments(event.postId);
      emit(CommentsLoaded(comments: response));
    } catch (err) {
      emit(CommentsError(message: err.toString()));
    }
  }

  Future<void> postComment(
      PostComment event, Emitter<CommentState> emit) async {
    emit(CommentsLoading());
    try {
      final List<Comment> response =
          await _commentRepository.postCommentToServer(event.comment);
      emit(CommentsLoaded(comments: response));
    } catch (err) {
      emit(CommentsError(message: err.toString()));
    }
  }
}
