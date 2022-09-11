import 'package:dio/dio.dart';
import '../../services/storage.dart';
import '../models/album.dart';

class AlbumsDataProvider {
  final Storage _storage = Storage();

  Future<Response> getAlbumsFromServer(final int userId) async {
    final Response response = await Dio()
        .get('https://jsonplaceholder.typicode.com/users/$userId/albums');
    return response;
  }

  List<Album> getAlbumsFromCache(int userId) {
    return _storage.albums
        .where((element) => element.userId == userId)
        .toList();
  }

  Future<void> addAlbumsToCache(final List<Album> albums) async {
    await _storage.putAlbums(albums);
  }
}
