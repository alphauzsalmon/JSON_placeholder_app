import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/comment/comment_bloc.dart';
import 'package:test_app_for_eclipse_ds/constants/size_config.dart';
import 'package:test_app_for_eclipse_ds/models/post.dart';
import 'package:test_app_for_eclipse_ds/repositories/comment_repositories/comment_repository.dart';
import 'package:test_app_for_eclipse_ds/screens/pages/add_comment_page.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/widgets.dart';

class PostDetailsPage extends StatelessWidget {
  final CommentEvent event;
  final Post post;
  const PostDetailsPage({
    Key? key,
    required this.post,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: post.title!,
      ),
      body: Column(
          children: [
            SizedBox(
              height: getHeight(20.0),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: getWidth(20.0),
              ),
              child: Text(
                post.title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getFont(20.0),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: getWidth(20.0),
              ),
              child: Text(
                post.body!,
                style: TextStyle(
                  fontSize: getFont(20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getWidth(20.0),
                right: getWidth(260.0),
                top: getHeight(20.0),
              ),
              child: Text(
                'Comments:',
                style: TextStyle(
                  fontSize: getFont(20.0),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: getHeight(400.0),
              child: BlocProvider<CommentBloc>(
                create: (context) =>
                    CommentBloc(CommentRepository())..add(event),
                child: BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                  if (state is CommentsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CommentsLoaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                                'name: "${state.comments[index].name}"\nemail: "${state.comments[index].email}"'),
                            subtitle: Text(state.comments[index].body!),
                          ),
                        );
                      },
                      itemCount: state.comments.length,
                    );
                  } else {
                    state as CommentsError;
                    return Text(state.message);
                  }
                }),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddCommentPage(post: post),
                  ),
                );
              },
              child: const Text('Add comment'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    getFont(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
