import 'package:test_app_for_eclipse_ds/models/photo.dart';

abstract class BasePhotoRepository {
  Future<List> getPhotosFromServer(int albumId);
  List<Photo> getPhotosFromCache(int albumId);
  Future<List<List>> getThumbnailPhotosFromServer(int albumId, int len);
  List<List<Photo>> getThumbnailPhotosFromCache(int albumId, int len);
}