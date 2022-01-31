import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/repositories/users_repositories/base_users_repository.dart';

class UserRepository extends BaseUserRepository {
  @override
  Future<List> getAllUsers() async {
      final Response response = await Dio().get('https://jsonplaceholder.typicode.com/users');
      return response.data;
  }
}