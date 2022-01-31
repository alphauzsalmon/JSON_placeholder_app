import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/comment/comment_bloc.dart';
import 'package:test_app_for_eclipse_ds/constants/size_config.dart';
import 'package:test_app_for_eclipse_ds/models/post.dart';
import 'package:test_app_for_eclipse_ds/screens/pages/post_detail_page.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/widgets.dart';

class PostsPage extends StatelessWidget {
  final List<Post> posts;
  final List<String> firstLines;
  const PostsPage({Key? key, required this.posts, required this.firstLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: 'Posts',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(posts[index].title!),
              subtitle: Text('${firstLines[index]}...'),
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
                    builder: (context) => PostDetailsPage(
                      event: LoadComments(posts[index].id!),
                      post: posts[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
        itemCount: posts.length,
      ),
    );
  }
}
