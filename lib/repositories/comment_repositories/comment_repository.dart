import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/comment.dart';
import 'package:test_app_for_eclipse_ds/repositories/comment_repositories/base_comment_repository.dart';

class CommentRepository extends BaseCommentRepository {
  @override
  Future<List> getCommentsFromServer(int postId) async {
    final Response response = await Dio().get('https://jsonplaceholder.typicode.com/posts/$postId/comments');
    return response.data;
  }

  @override
  List<Comment> getCommentsFromCache(int postId) {
    final List<Comment> comments = [];
    commentBox!.values.toList().forEach((element) {
      if (element.postId == postId) {
        comments.add(element);
      }
    });
    return comments;
  }

  @override
  Future<List> postCommentToServer(int postId, String name, String email, String body) async {
    final Response response = await Dio().post('https://jsonplaceholder.typicode.com/comments', data:
    {
      "postId": postId,
      "name": name,
      "email": email,
      "body": body
    });
    return [response.data];
  }
}