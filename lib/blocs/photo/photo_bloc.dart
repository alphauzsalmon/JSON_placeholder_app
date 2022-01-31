import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/hive.dart';
import 'package:test_app_for_eclipse_ds/models/photo.dart';
import 'package:test_app_for_eclipse_ds/repositories/photo_repositories/base_photo_repository.dart';

part 'photo_state.dart';
part 'photo_event.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final BasePhotoRepository _photoRepository;
  PhotoBloc(this._photoRepository) : super(PhotosLoading()) {
    on<LoadPhotos>(getPhotos);
    on<LoadThumbnailPhotos>(getPhotos);
  }

  Future<void> getPhotos(PhotoEvent event, Emitter<PhotoState> emit) async {
    emit(PhotosLoading());
    try {
      if (event is LoadThumbnailPhotos) {
        final List<Photo> photos = [];
        List<List<Photo>> response = _photoRepository
            .getThumbnailPhotosFromCache(event.albumId, event.len);
        if (response.first.isEmpty) {
          response = (await _photoRepository.getThumbnailPhotosFromServer(
                  event.albumId, event.len))
              .map((e) => e.map((photo) => Photo.fromJson(photo)).toList())
              .toList();
          for (var list in response) {
            await photoBox!.addAll(list);
          }
        }
        for (var list in response) {
          photos.add(list.first);
        }
        emit(PhotosLoaded(photos: photos));
      }
      if (event is LoadPhotos) {
        List<Photo> response =
            _photoRepository.getPhotosFromCache(event.albumId);
        if (response.isEmpty) {
          response =
              (await _photoRepository.getPhotosFromServer(event.albumId))
                  .map(
                    (e) => Photo.fromJson(e),
                  )
                  .toList();
        }
        emit(PhotosLoaded(photos: response));
      }
    } catch (err) {
      emit(
        PhotosError(message: err.toString()),
      );
    }
  }
}
