import 'package:test_app_for_eclipse_ds/models/album.dart';

abstract class BaseAlbumRepository {
  Future<List> getAlbumsFromServer(int userId);
  List<Album> getAlbumsFromCache(int userId);
}