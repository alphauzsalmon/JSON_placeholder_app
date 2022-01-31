import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/post.dart';
import 'package:test_app_for_eclipse_ds/repositories/post_repositories/base_post_repository.dart';

class PostRepository extends BasePostRepository {
  @override
  Future<List> getPostsFromServer(int userId) async {
    Response response = await Dio().get('https://jsonplaceholder.typicode.com/users/$userId/posts');
    return response.data;
  }

  @override
  List<Post> getPostsFromCache(int userId) {
    final List<Post> posts = [];
    postBox!.values.toList().forEach((e) {
      if (e.userId == userId) {
        posts.add(e);
      }
    });
    return posts;
  }
}