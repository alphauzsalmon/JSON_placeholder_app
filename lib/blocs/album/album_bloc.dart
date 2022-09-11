import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/album.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/album_repositories/base_album_repository.dart';
import '../../infrastructure/models/photo.dart';
import '../../infrastructure/repositories/photo_repositories/base_photo_repository.dart';

part 'album_state.dart';
part 'album_event.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final BaseAlbumRepository _albumRepository;
  final BasePhotoRepository _photoRepository;
  AlbumBloc(this._albumRepository, this._photoRepository)
      : super(AlbumsLoading()) {
    on<LoadAlbums>(getAlbums);
  }

  Future<void> getAlbums(LoadAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumsLoading());
    try {
      List<Album> albums = await _albumRepository.getAlbums(event.userId);
      final List<Photo> photos = await _photoRepository.getPhotosForThumbnail(
          albums.first.id!, albums.length);
      emit(AlbumsLoaded(albums: albums, photos: photos));
    } catch (err) {
      emit(AlbumsError(message: err.toString()));
    }
  }
}
