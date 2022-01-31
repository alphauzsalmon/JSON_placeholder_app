import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/album.dart';
import 'package:test_app_for_eclipse_ds/models/comment.dart';
import 'package:test_app_for_eclipse_ds/models/photo.dart';
import 'package:test_app_for_eclipse_ds/models/post.dart';
import 'package:test_app_for_eclipse_ds/models/user.dart';
import 'package:test_app_for_eclipse_ds/screens/pages/list_of_users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();

  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter<User>(UserAdapter())
    ..registerAdapter<Address>(AdressAdapter())
    ..registerAdapter<Geo>(GeoAdapter())
    ..registerAdapter<Company>(CompanyAdapter())
    ..registerAdapter<Post>(PostAdapter())
    ..registerAdapter<Album>(AlbumAdapter())
    ..registerAdapter<Photo>(PhotoAdapter())
    ..registerAdapter<Comment>(CommentAdapter());

  await openHiveBox();

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
