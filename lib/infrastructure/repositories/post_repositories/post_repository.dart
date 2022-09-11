import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/posts_data_provider.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/post.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/post_repositories/base_post_repository.dart';

class PostRepository extends BasePostRepository {
  PostRepository(this._dataProvider);
  final PostsDataProvider _dataProvider;

  @override
  Future<List<Post>> getPosts(int userId) async {
    List<Post> posts = _dataProvider.getPostsFromCache(userId);
    if (posts.isEmpty) {
      final Response response = await _dataProvider.getPostsFromServer(userId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        posts = (response.data as List).map((e) => Post.fromJson(e)).toList();
        await _dataProvider.addPostToCache(posts);
        return posts;
      }
      throw Exception(response.statusCode);
    }
    return posts;
  }
}
