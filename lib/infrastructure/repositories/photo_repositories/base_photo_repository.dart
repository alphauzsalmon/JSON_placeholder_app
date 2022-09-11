import 'package:test_app_for_eclipse_ds/infrastructure/models/photo.dart';

abstract class BasePhotoRepository {
  Future<List<Photo>> getPhotosForThumbnail(final int firstAlbumId, final int len);
  Future<List<Photo>> getPhotos(final int albumId);
}