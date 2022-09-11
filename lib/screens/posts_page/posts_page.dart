import 'package:flutter/material.dart';
import 'package:test_app_for_eclipse_ds/services/size_config.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/post.dart';
import 'package:test_app_for_eclipse_ds/screens/post_details_page/post_detail_page.dart';
import '../widgets/app_bar_widget.dart';

class PostsPage extends StatelessWidget {
  final List<Post> posts;
  const PostsPage({
    Key? key,
    required this.posts,
  }) : super(key: key);

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
              subtitle: Text('${posts[index].firstLine}...'),
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
