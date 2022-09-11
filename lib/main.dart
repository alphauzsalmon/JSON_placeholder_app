import 'package:flutter/material.dart';
import 'package:test_app_for_eclipse_ds/services/storage.dart';
import 'package:test_app_for_eclipse_ds/screens/users_page/list_of_users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListOfUsersPage(),
    );
  }
}
