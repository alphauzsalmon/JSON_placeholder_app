import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/user/user_bloc.dart';
import 'package:test_app_for_eclipse_ds/constants/size_config.dart';
import 'package:test_app_for_eclipse_ds/repositories/users_repositories/users_repository.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/widgets.dart';

class ListOfUsersPage extends StatelessWidget {
  const ListOfUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(
          LoadUsers(),
        ),
      child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const CircularLoading();
            } else if (state is UsersLoaded) {
              return Scaffold(
                appBar: AppBarWidget(text: 'Users',),
                body: Users(users: state.users),
              );
            } else {
              state as UsersError;
              return ErrorText(text: state.message);
            }
          },
        ),
    );
  }
}
