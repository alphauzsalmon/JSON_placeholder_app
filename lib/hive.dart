import 'package:hive/hive.dart';
import 'package:test_app_for_eclipse_ds/models/album.dart';
import 'package:test_app_for_eclipse_ds/models/comment.dart';
import 'package:test_app_for_eclipse_ds/models/photo.dart';
import 'package:test_app_for_eclipse_ds/models/user.dart';
import 'package:test_app_for_eclipse_ds/models/post.dart';


Box<User>? userBox;
Box<Post>? postBox;
Box<Album>? albumBox;
Box<Photo>? photoBox;
Box<Comment>? commentBox;

openHiveBox() async {
  if (userBox != null) {
    if (!userBox!.isOpen) {
      userBox = await Hive.openBox<User>('userBox');
    }
  }
  else {
    userBox = await Hive.openBox<User>('userBox');
  }

  if (postBox != null) {
    if (!postBox!.isOpen) {
      postBox = await Hive.openBox<Post>('postBox');
    }
  }
  else {
    postBox = await Hive.openBox<Post>('postBox');
  }

  if (albumBox != null) {
    if (!albumBox!.isOpen) {
      albumBox = await Hive.openBox<Album>('albumBox');
    }
  }
  else {
    albumBox = await Hive.openBox<Album>('albumBox');
  }

  if (photoBox != null) {
    if (!photoBox !.isOpen) {
      photoBox  = await Hive.openBox<Photo>('photoBox');
    }
  }
  else {
    photoBox  = await Hive.openBox<Photo>('photoBox');
  }

  if (commentBox != null) {
    if (!commentBox !.isOpen) {
      commentBox = await Hive.openBox<Comment>('commentBox');
    }
  }
  else {
    commentBox = await Hive.openBox<Comment>('commentBox');
  }
}