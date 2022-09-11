import 'package:test_app_for_eclipse_ds/infrastructure/models/post.dart';

abstract class BasePostRepository {
  Future<List<Post>> getPosts(int userId);
}