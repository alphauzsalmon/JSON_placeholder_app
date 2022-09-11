import 'package:flutter/material.dart';
import 'package:test_app_for_eclipse_ds/blocs/comment/comment_bloc.dart';
import 'package:test_app_for_eclipse_ds/services/size_config.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/comment.dart';

class AddCommentPage extends StatelessWidget {
  AddCommentPage({Key? key, required this.postId}) : super(key: key);
  final int postId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      labelText: 'Name'),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "You must enter your name";
                    }
                    return null;
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
                      labelText: 'Email'),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "You must enter your email";
                    }
                    return null;
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
                      labelText: 'Comment'),
                  maxLines: 3,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "You must enter your comment";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(PostComment(
                        comment: Comment(
                      postId: postId,
                      name: _nameController.text,
                      email: _emailController.text,
                      body: _commentController.text,
                    )));
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
