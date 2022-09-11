import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/photos_data_provider.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/photo.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/photo_repositories/base_photo_repository.dart';

class PhotoRepository extends BasePhotoRepository {
  PhotoRepository(this._dataProvider);
  final PhotosDataProvider _dataProvider;

  @override
  Future<List<Photo>> getPhotos(final int albumId) async {
    List<Photo> photos = _dataProvider.getPhotosFromCache(albumId);
    if (photos.isEmpty) {
      final Response response =
          await _dataProvider.getPhotosFromServer(albumId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        photos = (response.data as List).map((e) => Photo.fromJson(e)).toList();
        await _dataProvider.addPhotosToCache([photos]);
        return photos;
      }
      throw Exception(response.statusCode);
    }
    return photos;
  }

  @override
  Future<List<Photo>> getPhotosForThumbnail(
      final int firstAlbumId, final int len) async {
    List<List<Photo>> photoResponse =
        _dataProvider.getPhotosForThumbnailFromCache(firstAlbumId, len);
    if (photoResponse.isEmpty || photoResponse.first.isEmpty) {
      try {
        final List<List> responses = await _dataProvider
            .getPhotosForThumbnailFromServer(firstAlbumId, len);
        photoResponse = responses
            .map((list) =>
                (list).map((e) => Photo.fromJson(e)).toList())
            .toList();
        await _dataProvider.addPhotosToCache(photoResponse);
      } catch (err) {
        throw Exception(err);
      }
    }
    final List<Photo> photos = [];
    for (var list in photoResponse) {
      photos.add(list.first);
    }
    return photos;
  }
}
