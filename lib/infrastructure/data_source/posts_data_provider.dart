import 'package:dio/dio.dart';
import '../../services/storage.dart';
import '../../infrastructure/models/post.dart';

class PostsDataProvider {
  final Storage _storage = Storage();

  Future<Response> getPostsFromServer(final int userId) async {
    Response response = await Dio()
        .get('https://jsonplaceholder.typicode.com/users/$userId/posts');
    return response;
  }

  List<Post> getPostsFromCache(final int userId) {
    return _storage.posts.where((element) => element.userId == userId).toList();
  }

  Future<void> addPostToCache(final List<Post> posts) async {
    await _storage.putPosts(posts);
  }
}
