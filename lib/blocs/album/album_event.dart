part of 'album_bloc.dart';

abstract class AlbumEvent {
  const AlbumEvent();
}

class LoadAlbums extends AlbumEvent {
  final int userId;
  const LoadAlbums(this.userId);
}