import 'package:flutter/material.dart';
import 'package:test_app_for_eclipse_ds/blocs/comment/comment_bloc.dart';
import 'package:test_app_for_eclipse_ds/constants/size_config.dart';
import 'package:test_app_for_eclipse_ds/models/post.dart';
import 'package:test_app_for_eclipse_ds/screens/pages/post_detail_page.dart';

class AddCommentPage extends StatelessWidget {
  final Post post;
  AddCommentPage({Key? key, required this.post}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(10.0),
                ),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name',
                    labelText: 'Name'
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "You must enter your name";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(10.0),
                ),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                    labelText: 'Email'
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "You must enter your email";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(10.0),
                ),
                child: TextFormField(
                  controller: _commentController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your comment',
                    labelText: 'Comment'
                  ),
                  maxLines: 3,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "You must enter your comment";
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => PostDetailsPage(
                          event: PostComment(
                            postId: post.id!,
                            name: _nameController.text,
                            email: _emailController.text,
                            body: _commentController.text,
                          ),
                          post: post,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Send'),
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
        ),
      ),
    );
  }
}
