import '../../models/user.dart';

abstract class BaseUserRepository {
  Future<List<User>> getAllUsers();
}