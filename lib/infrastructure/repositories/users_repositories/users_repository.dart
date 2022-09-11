import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/users_repositories/base_users_repository.dart';
import '../../data_source/users_data_provider.dart';
import '../../models/user.dart';

class UserRepository extends BaseUserRepository {
  UserRepository(this._dataProvider);
  final UsersDataProvider _dataProvider;
  @override
  Future<List<User>> getAllUsers() async {
    List<User> users = _dataProvider.getUsersFromCache();
    if (users.isEmpty) {
      final Response response = await _dataProvider.getUsersFromServer();
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        users = (response.data as List).map((e) => User.fromJson(e)).toList();
        await _dataProvider.addUsersToCache(users);
        return users;
      }
      throw Exception(response.statusCode);
    }
    return users;
  }
}
