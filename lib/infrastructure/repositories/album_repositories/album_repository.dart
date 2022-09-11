import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/albums_data_provider.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/album.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/album_repositories/base_album_repository.dart';

class AlbumRepository extends BaseAlbumRepository {
  AlbumRepository(this._dataProvider);
  final AlbumsDataProvider _dataProvider;

  @override
  Future<List<Album>> getAlbums(final int userId) async {
    List<Album> albums = _dataProvider.getAlbumsFromCache(userId);
    if (albums.isEmpty) {
      final Response response = await _dataProvider.getAlbumsFromServer(userId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        albums = (response.data as List).map((e) => Album.fromJson(e)).toList();
        await _dataProvider.addAlbumsToCache(albums);
        return albums;
      } else {
        throw Exception(response.statusCode);
      }
    }
    return albums;
  }
}
