import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/album.dart';
import 'package:test_app_for_eclipse_ds/repositories/album_repositories/base_album_repository.dart';

class AlbumRepository extends BaseAlbumRepository {
  @override
  Future<List> getAlbumsFromServer(int userId) async {
    Response response = await Dio().get('https://jsonplaceholder.typicode.com/users/$userId/albums');
    return response.data;
  }

  @override
  List<Album> getAlbumsFromCache(int userId) {
    List<Album> albums = [];
    albumBox!.values.toList().forEach((e) {
      if (e.userId == userId) {
        albums.add(e);
      }
    });
    return albums;
  }
}