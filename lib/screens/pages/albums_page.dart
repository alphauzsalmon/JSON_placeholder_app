import 'package:flutter/material.dart';
import 'package:test_app_for_eclipse_ds/constants/size_config.dart';
import 'package:test_app_for_eclipse_ds/models/album.dart';
import 'package:test_app_for_eclipse_ds/models/photo.dart';
import 'package:test_app_for_eclipse_ds/screens/pages/album_details_page.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/widgets.dart';

class AlbumsPage extends StatelessWidget {
  final List<Album> albums;
  final List<Photo> photos;
  const AlbumsPage({Key? key, required this.albums, required this.photos})
      : super(key: key);

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
