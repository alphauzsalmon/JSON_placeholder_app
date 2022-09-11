import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/comments_data_provider.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/comment.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/comment_repositories/base_comment_repository.dart';

class CommentRepository extends BaseCommentRepository {
  final CommentsDataProvider _dataProvider;
  CommentRepository(this._dataProvider);

  @override
  Future<List<Comment>> getComments(int postId) async {
    List<Comment> comments = _dataProvider.getCommentsFromCache(postId);
    if (comments.isEmpty) {
      final Response response =
          await _dataProvider.getCommentsFromServer(postId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        comments = (response.data as List).map((e) => Comment.fromJson(e)).toList();
        await _dataProvider.addCommentsToCache(comments);
        return comments;
      }
      throw Exception(response.statusCode);
    }
    return comments;
  }

  @override
  Future<List<Comment>> postCommentToServer(final Comment comment) async {
    final Response response = await _dataProvider.postCommentToServer(comment);
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final Comment comment = Comment.fromJson(response.data);
      final List<Comment> comments =
          _dataProvider.getCommentsFromCache(comment.postId!);
      comments.add(comment);
      await _dataProvider.addCommentsToCache([comment]);
      return comments;
    }
    throw Exception(response.statusCode);
  }
}
