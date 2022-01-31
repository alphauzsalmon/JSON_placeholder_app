import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/album/album_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/post/post_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/photo/photo_bloc.dart';
import 'package:test_app_for_eclipse_ds/constants/size_config.dart';
import 'package:test_app_for_eclipse_ds/models/user.dart';
import 'package:test_app_for_eclipse_ds/repositories/album_repositories/album_repository.dart';
import 'package:test_app_for_eclipse_ds/repositories/photo_repositories/photo_repository.dart';
import 'package:test_app_for_eclipse_ds/repositories/post_repositories/post_repository.dart';
import 'package:test_app_for_eclipse_ds/screens/pages/albums_page.dart';
import 'package:test_app_for_eclipse_ds/screens/pages/posts_page.dart';
import 'package:test_app_for_eclipse_ds/screens/pages/user_page.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String text;
  AppBarWidget({Key? key, required this.text})
      : preferredSize = Size.fromHeight(getHeight(44.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      centerTitle: true,
    );
  }

  @override
  final Size preferredSize;
}

class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Users extends StatelessWidget {
  final List<User> users;
  const Users({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(users[index].username!),
            subtitle: Text(users[index].name!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserPage(user: users[index]),
                ),
              );
            },
          ),
        );
      },
      itemCount: users.length,
    );
  }
}

class ErrorText extends StatelessWidget {
  final String text;
  const ErrorText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'Error'),
      body: Center(
        child: Text(text),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const CardWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(fontSize: getFont(15.0)),
        ),
        subtitle: Text(
          subTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getFont(20.0),
          ),
        ),
      ),
    );
  }
}

class PostsWidget extends StatelessWidget {
  final User user;

  const PostsWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(PostRepository())..add(LoadPosts(user.id!)),
      child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        if (state is PostsLoading) {
          return const CircularProgressIndicator();
        } else if (state is PostsLoaded) {
          List<String> firstLines = [];
          for (int i = 0; i < state.posts.length; i++) {
            firstLines.insert(i, state.posts[i].body!.split('\n')[0]);
          }
          return Card(
            margin: EdgeInsets.symmetric(
              horizontal: getWidth(5.0),
            ),
            child: Column(
              children: [
                Text(
                  'Posts:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getFont(20.0),
                  ),
                ),
                SizedBox(
                  height: getHeight(230.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          state.posts[index].title!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getFont(16.0),
                          ),
                        ),
                        subtitle: Text(
                          firstLines[index] + '...',
                          style: TextStyle(
                            fontSize: getFont(16.0),
                          ),
                        ),
                      );
                    },
                    itemCount: 3,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostsPage(
                            posts: state.posts, firstLines: firstLines),
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
          state as PostsError;
          return Text(state.message);
        }
      }),
    );
  }
}

class AlbumsWidget extends StatelessWidget {
  final User user;

  const AlbumsWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumBloc>(
      create: (context) =>
          AlbumBloc(AlbumRepository())..add(LoadAlbums(user.id!)),
      child: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumsLoading) {
            return const CircularProgressIndicator();
          } else if (state is AlbumsLoaded) {
            return BlocProvider<PhotoBloc>(
              create: (context) => PhotoBloc(PhotoRepository())
                ..add(LoadThumbnailPhotos(state.albums.first.id!, state.albums.length)),
              child: BlocBuilder<PhotoBloc, PhotoState>(
                builder: (context, photoState) {
                  if (photoState is PhotosLoading) {
                    return const CircularProgressIndicator();
                  } else if (photoState is PhotosLoaded) {
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
                                    title: Text(
                                      state.albums[index].title!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: getFont(20.0),
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(photoState
                                          .photos[index].thumbnailUrl!),
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
                                    photos: photoState.photos,
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
                    photoState as PhotosError;
                    return Text(photoState.message);
                  }
                },
              ),
            );
          } else {
            state as AlbumsError;
            return Text(state.message);
          }
        },
      ),
    );
  }
}
