import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/photo.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/photo_repositories/base_photo_repository.dart';

part 'photo_state.dart';
part 'photo_event.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final BasePhotoRepository _photoRepository;
  PhotoBloc(this._photoRepository) : super(PhotosLoading()) {
    on<LoadPhotos>(getPhotos);
  }

  Future<void> getPhotos(PhotoEvent event, Emitter<PhotoState> emit) async {
    emit(PhotosLoading());
    try {
      if (event is LoadPhotos) {
        List<Photo> response = await _photoRepository.getPhotos(event.albumId);
        emit(PhotosLoaded(photos: response));
      }
    } catch (err) {
      emit(
        PhotosError(message: err.toString()),
      );
    }
  }
}
