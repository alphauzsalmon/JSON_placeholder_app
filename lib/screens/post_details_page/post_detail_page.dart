import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_for_eclipse_ds/blocs/comment/comment_bloc.dart';
import 'package:test_app_for_eclipse_ds/services/size_config.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/data_source/comments_data_provider.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/post.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/repositories/comment_repositories/comment_repository.dart';
import 'package:test_app_for_eclipse_ds/screens/add_comment_page/add_comment_page.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/error_widget.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/loading_widget.dart';
import '../widgets/app_bar_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(text: post.title!),
        body: ListView(children: [
          SizedBox(height: getHeight(20.0)),
          Container(
              margin: EdgeInsets.symmetric(
                horizontal: getWidth(20.0),
              ),
              child: Text(post.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getFont(20.0),
                    color: Theme.of(context).primaryColor,
                  ))),
          Container(
              margin: EdgeInsets.symmetric(
                horizontal: getWidth(20.0),
              ),
              child: Text(post.body!,
                  style: TextStyle(
                    fontSize: getFont(20.0),
                  ))),
          SizedBox(height: getHeight(20.0)),
          Row(children: [
            SizedBox(width: getWidth(20.0)),
            Text(
              'Comments:',
              style: TextStyle(
                fontSize: getFont(20.0),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            )
          ]),
          BlocProvider<CommentBloc>(
              create: (context) =>
                  CommentBloc(CommentRepository(CommentsDataProvider()))
                    ..add(LoadComments(post.id!)),
              child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                if (state is CommentsError) {
                  return ShowErrorWidget(message: state.message);
                } else if (state is CommentsLoaded) {
                  return Column(children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Card(
                          child: ListTile(
                              title: Text.rich(TextSpan(children: [
                                const TextSpan(
                                    text: 'name: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: '"${state.comments[index].name}"\n'),
                                const TextSpan(
                                    text: 'email: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: '"${state.comments[index].email}"'),
                              ])),
                              subtitle: Text(state.comments[index].body!))),
                      itemCount: state.comments.length,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final CommentEvent? event =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddCommentPage(postId: post.id!),
                            ),
                          );
                          if (event != null) {
                            BlocProvider.of<CommentBloc>(context).add(event);
                          }
                        },
                        child: const Text('Add comment'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getFont(30.0)),
                        )))
                  ]);
                }
                return const LoadingWidget();
              }))
        ]));
  }
}
