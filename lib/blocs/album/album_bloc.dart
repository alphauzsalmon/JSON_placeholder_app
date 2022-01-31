import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/album.dart';
import 'package:test_app_for_eclipse_ds/repositories/album_repositories/base_album_repository.dart';

part 'album_state.dart';
part 'album_event.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final BaseAlbumRepository _albumRepository;
  AlbumBloc(this._albumRepository) : super(AlbumsLoading()) {
    on<LoadAlbums>(getAlbums);
  }

  Future<void> getAlbums(LoadAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumsLoading());
    try {
      List<Album> response = _albumRepository.getAlbumsFromCache(event.userId);
      if (response.isEmpty) {
        response = (await _albumRepository.getAlbumsFromServer(event.userId))
            .map(
              (e) => Album.fromJson(e),
        )
            .toList();
        await albumBox!.addAll(response);
        emit(AlbumsLoaded(albums: response));
      }
      else {
        emit(AlbumsLoaded(albums: response));
      }
    } catch (err) {
      emit(
        AlbumsError(message: err.toString()),
      );
    }
  }
}