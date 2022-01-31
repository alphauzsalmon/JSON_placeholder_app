import 'package:test_app_for_eclipse_ds/models/post.dart';

abstract class BasePostRepository {
  Future<List> getPostsFromServer(int userId);
  List<Post> getPostsFromCache(int userId);
}