import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/user/user_bloc.dart';
import 'package:test_app_for_eclipse_ds/services/size_config.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/users_data_provider.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/users_repositories/users_repository.dart';
import 'package:test_app_for_eclipse_ds/screens/users_page/users_widget.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/loading_widget.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/error_widget.dart';

class ListOfUsersPage extends StatelessWidget {
  const ListOfUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(UsersDataProvider()),
      )..add(LoadUsers()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UsersError) {
            return ShowErrorWidget(message: state.message);
          } else if (state is UsersLoaded) {
            return Scaffold(
              appBar: AppBarWidget(
                text: 'Users',
              ),
              body: Users(users: state.users),
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
