part of 'photo_bloc.dart';

abstract class PhotoEvent {
  const PhotoEvent();
}

class LoadPhotos extends PhotoEvent {
  final int albumId;
  const LoadPhotos(this.albumId);
}

class LoadThumbnailPhotos extends PhotoEvent {
  final int albumId;
  final int len;
  const LoadThumbnailPhotos(this.albumId, this.len);
}