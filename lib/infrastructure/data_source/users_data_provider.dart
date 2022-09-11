import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/user.dart';
import '../../services/storage.dart';

class UsersDataProvider {
  final Storage _storage = Storage();

  Future<Response> getUsersFromServer() async {
    final Response response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    return response;
  }

  List<User> getUsersFromCache() {
    return _storage.users;
  }

  Future<void> addUsersToCache(List<User> users) async {
    await _storage.putUsers(users);
  }
}
