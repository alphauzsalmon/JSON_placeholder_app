import 'package:dio/dio.dart';
import '../../services/storage.dart';
import '../../infrastructure/models/photo.dart';

class PhotosDataProvider {
  final Storage _storage = Storage();

  Future<Response> getPhotosFromServer(final int albumId) async {
    Response response = await Dio()
        .get('https://jsonplaceholder.typicode.com/albums/$albumId/photos');
    return response;
  }

  List<Photo> getPhotosFromCache(final int albumId) {
    return _storage.photos
        .where((element) => element.albumId == albumId)
        .toList();
  }

  Future<List<List>> getPhotosForThumbnailFromServer(
      final int firstAlbumId, final int len) async {
    final List<List> responses = [];
    Response response;
    for (int i = firstAlbumId; i < firstAlbumId + len; i++) {
      response = await getPhotosFromServer(i);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        responses.add(response.data);
      } else {
        throw Exception(response.statusCode);
      }
    }
    return responses;
  }

  List<List<Photo>> getPhotosForThumbnailFromCache(
      final int firstAlbumId, final int len) {
    final List<List<Photo>> photos = [];
    for (int i = 0, j = firstAlbumId; i < len; i++, j++) {
      photos.insert(i, []);
      for (Photo photo in (_storage.photos)) {
        if (photo.albumId == j) {
          photos[i].add(photo);
        }
      }
    }
    return photos;
  }

  Future<void> addPhotosToCache(final List<List<Photo>> photos) async {
    for (var element in photos) {
      await _storage.putPhotos(element);
    }
  }
}
