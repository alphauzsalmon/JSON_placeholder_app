import 'package:dio/dio.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/photo.dart';
import 'package:test_app_for_eclipse_ds/repositories/photo_repositories/base_photo_repository.dart';

class PhotoRepository extends BasePhotoRepository {
  @override
  Future<List> getPhotosFromServer(int albumId) async {
    Response response = await Dio().get('https://jsonplaceholder.typicode.com/albums/$albumId/photos');
    return response.data;
  }

  @override
  List<Photo> getPhotosFromCache(int albumId) {
    final List<Photo> photos = [];
    photoBox!.values.toList().forEach((element) {
      if (element.albumId == albumId) {
        photos.add(element);
      }
    });
    return photos;
  }

  @override
  Future<List<List>> getThumbnailPhotosFromServer(int albumId, int len) async {
    final List<List> photos = [];
    Response response;
    for (int i = albumId; i < albumId + len; i++) {
      response = await Dio().get('https://jsonplaceholder.typicode.com/albums/$i/photos');
      photos.add(response.data);
    }
    return photos;
  }

  @override
  List<List<Photo>> getThumbnailPhotosFromCache(int albumId, int len) {
    final List<List<Photo>> photos = [];
    for (int i = 0; i < len; i++) {
      photos.insert(i, []);
    }
    for (int i = 0, j = albumId; i < len; i++, j++) {
      for (Photo photo in (photoBox!.values.toList())) {
        if (photo.albumId == j) {
          photos[i].add(photo);
        }
      }
    }
    return photos;
  }
}