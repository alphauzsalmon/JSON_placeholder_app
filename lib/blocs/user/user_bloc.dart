import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/user.dart';
import 'package:test_app_for_eclipse_ds/repositories/users_repositories/base_users_repository.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final BaseUserRepository _userRepository;
  UserBloc(this._userRepository) : super(UsersLoading()) {
    on<LoadUsers>(getUsers);
  }

  Future<void> getUsers(UserEvent event, Emitter<UserState> emit) async {
    emit(UsersLoading());
    try {
      if (userBox!.isEmpty) {
        final List<User> response = (await _userRepository.getAllUsers())
            .map(
              (e) => User.fromJson(e),
            )
            .toList();
        await userBox!.addAll(response);
        emit(UsersLoaded(users: response));
      } else {
        emit(UsersLoaded(users: userBox!.values.toList()));
      }
    } catch (err) {
      emit(
        UsersError(message: err.toString()),
      );
    }
  }
}
