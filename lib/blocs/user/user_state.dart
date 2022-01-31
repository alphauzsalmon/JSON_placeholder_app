part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;

  const UsersLoaded({this.users = const <User>[]});

  @override
  List<Object?> get props => [users];
}

class UsersError extends UserState {
  final String message;
  const UsersError({required this.message});
}