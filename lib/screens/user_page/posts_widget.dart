import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/posts_data_provider.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/error_widget.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/loading_widget.dart';
import '../../blocs/post/post_bloc.dart';
import '../../services/size_config.dart';
import '../../infrastructure/repositories/post_repositories/post_repository.dart';
import '../post_details_page/post_detail_page.dart';
import '../posts_page/posts_page.dart';

class PostsWidget extends StatelessWidget {
  final int userId;

  const PostsWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(PostRepository(PostsDataProvider()))..add(LoadPosts(userId)),
      child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        if (state is PostsError) {
          return ShowErrorWidget(message: state.message);
        } else if (state is PostsLoaded) {
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
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PostDetailsPage(
                                post: state.posts[index],
                              ),
                            ),
                          );
                        },
                        title: Text(
                          state.posts[index].title!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getFont(16.0),
                          ),
                        ),
                        subtitle: Text(
                          state.posts[index].firstLine! + '...',
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
                        builder: (context) => PostsPage(posts: state.posts),
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
      }),
    );
  }
}
