import 'package:test_app_for_eclipse_ds/infrastructure/models/album.dart';

abstract class BaseAlbumRepository {
  Future<List<Album>> getAlbums(final int userId);
}