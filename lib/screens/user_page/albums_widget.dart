import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/albums_data_provider.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/photos_data_provider.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/error_widget.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/loading_widget.dart';
import '../../blocs/album/album_bloc.dart';
import '../../services/size_config.dart';
import '../../infrastructure/repositories/album_repositories/album_repository.dart';
import '../../infrastructure/repositories/photo_repositories/photo_repository.dart';
import '../album_details_page/album_details_page.dart';
import '../albums_page/albums_page.dart';

class AlbumsWidget extends StatelessWidget {
  final int userId;

  const AlbumsWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumBloc>(
      create: (context) => AlbumBloc(AlbumRepository(AlbumsDataProvider()),
          PhotoRepository(PhotosDataProvider()))
        ..add(LoadAlbums(userId)),
      child: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumsError) {
            return ShowErrorWidget(message: state.message);
          } else if (state is AlbumsLoaded) {
            return Card(
              margin: EdgeInsets.symmetric(
                horizontal: getWidth(5.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Albums:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getFont(20.0),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(200.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AlbumDetailsPage(
                                    title: state.albums[index].title!,
                                    albumId: state.albums[index].id!,
                                  ),
                                ),
                              );
                            },
                            title: Text(
                              state.albums[index].title!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getFont(20.0),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  state.photos[index].thumbnailUrl!),
                            ));
                      },
                      itemCount: 3,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AlbumsPage(
                            albums: state.albums,
                            photos: state.photos,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getFont(25.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
