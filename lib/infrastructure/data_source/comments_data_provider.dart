import 'package:dio/dio.dart';
import '../../services/storage.dart';
import '../../infrastructure/models/comment.dart';

class CommentsDataProvider {
  final Storage _storage = Storage();

  Future<Response> getCommentsFromServer(final int postId) async {
    final Response response = await Dio()
        .get('https://jsonplaceholder.typicode.com/posts/$postId/comments');
    return response;
  }

  List<Comment> getCommentsFromCache(final int postId) {
    return _storage.comments
        .where((element) => element.postId == postId)
        .toList();
  }

  Future<Response> postCommentToServer(final Comment comment) async {
    final Response response = await Dio().post(
        'https://jsonplaceholder.typicode.com/comments',
        data: comment.toJson());
    return response;
  }

  Future<void> addCommentsToCache(final List<Comment> comments) async {
    await _storage.putComments(comments);
  }
}
