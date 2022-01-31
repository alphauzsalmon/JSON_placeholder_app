import 'package:test_app_for_eclipse_ds/models/comment.dart';

abstract class BaseCommentRepository {
  Future<List> getCommentsFromServer(int postId);
  List<Comment> getCommentsFromCache(int postId);
  Future<List> postCommentToServer(int postId, String name, String email, String body);
}