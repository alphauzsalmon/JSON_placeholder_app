import 'package:test_app_for_eclipse_ds/infrastructure/models/comment.dart';

abstract class BaseCommentRepository {
  Future<List<Comment>> postCommentToServer(final Comment comment);
  Future<List<Comment>> getComments(final int postId);
}