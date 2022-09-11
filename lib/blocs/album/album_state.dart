part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object?> get props => [];
}

class AlbumsLoading extends AlbumState {}

class AlbumsLoaded extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;

  const AlbumsLoaded({
    this.albums = const <Album>[],
    this.photos = const <Photo>[],
  });

  @override
  List<Object?> get props => [albums];
}

class AlbumsError extends AlbumState {
  final String message;
  const AlbumsError({required this.message});
}
