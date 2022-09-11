import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/user.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/users_repositories/base_users_repository.dart';

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
      final List<User> response = await _userRepository.getAllUsers();
      emit(UsersLoaded(users: response));
    } catch (err, s) {
      emit(
        UsersError(message: err.toString() + s.toString()),
      );
    }
  }
}
