import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/photo/photo_bloc.dart';
import 'package:test_app_for_eclipse_ds/constants/size_config.dart';
import 'package:test_app_for_eclipse_ds/repositories/photo_repositories/photo_repository.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/widgets.dart';

class AlbumDetailsPage extends StatelessWidget {
  final String title;
  final int albumId;
  const AlbumDetailsPage({
    Key? key,
    required this.title,
    required this.albumId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
      create: (context) =>
          PhotoBloc(PhotoRepository())..add(LoadPhotos(albumId)),
      child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotosLoading) {
            return const CircularLoading();
          } else if (state is PhotosLoaded) {
            final PageController pageController = PageController();
            return Scaffold(
              appBar: AppBarWidget(
                text: title,
              ),
              body: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            FadeInImage.assetNetwork(
                              placeholder: 'assets/circular_loading.gif',
                              image: state.photos[index].url!,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: getHeight(10.0),
                              ),
                              child: Text(
                                '${index + 1} / ${state.photos.length}',
                                style: TextStyle(
                                  fontSize: getFont(50.0),
                                ),
                              ),
                            ),
                            Text(
                              state.photos[index].title!,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getFont(30.0),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: state.photos.length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getHeight(650.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear,
                              );
                            },
                            child: const Text('<<Prev')),
                        ElevatedButton(
                            onPressed: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear,
                              );
                            },
                            child: const Text('Next>>')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            state as PhotosError;
            return ErrorText(text: state.message);
          }
        },
      ),
    );
  }
}
