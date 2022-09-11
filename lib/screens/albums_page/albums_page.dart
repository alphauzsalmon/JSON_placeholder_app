import 'package:flutter/material.dart';
import 'package:test_app_for_eclipse_ds/services/size_config.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/album.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/photo.dart';
import 'package:test_app_for_eclipse_ds/screens/album_details_page/album_details_page.dart';
import '../widgets/app_bar_widget.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({
    Key? key,
    required this.albums,
    required this.photos,
  }) : super(key: key);

  final List<Album> albums;
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: 'Albums',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(photos[index].thumbnailUrl!),
              ),
              title: Text(albums[index].title!),
              trailing: SizedBox(
                width: getWidth(90.0),
                child: Row(
                  children: [
                    Text(
                      'See more',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AlbumDetailsPage(
                      title: albums[index].title!,
                      albumId: albums[index].id!,
                    ),
                  ),
                );
              },
            ),
          );
        },
        itemCount: albums.length,
      ),
    );
  }
}
