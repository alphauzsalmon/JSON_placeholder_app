import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/album.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/comment.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/photo.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/user.dart';
import 'package:test_app_for_eclipse_ds/infrastructure/models/post.dart';

class Storage {
  final Box<User>? _userBox = Hive.box('userBox');
  final Box<Post>? _postBox = Hive.box('postBox');
  final Box<Album>? _albumBox = Hive.box('albumBox');
  final Box<Photo>? _photoBox = Hive.box('photoBox');
  final Box<Comment>? _commentBox = Hive.box('commentBox');

  List<User> get users => _userBox?.values.toList() ?? <User>[];
  List<Post> get posts => _postBox?.values.toList() ?? <Post>[];
  List<Album> get albums => _albumBox?.values.toList() ?? <Album>[];
  List<Photo> get photos => _photoBox?.values.toList() ?? <Photo>[];
  List<Comment> get comments => _commentBox?.values.toList() ?? <Comment>[];

  Future<void> putUsers(final List<User> users) async {
    await _userBox!.addAll(users);
  }

  Future<void> putPosts(final List<Post> posts) async {
    await _postBox!.addAll(posts);
  }

  Future<void> putAlbums(final List<Album> albums) async {
    await _albumBox!.addAll(albums);
  }

  Future<void> putPhotos(final List<Photo> photos) async {
    await _photoBox!.addAll(photos);
  }

  Future<void> putComments(final List<Comment> comments) async {
    await _commentBox!.addAll(comments);
  }

  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDir.path)
      ..registerAdapter<User>(UserAdapter())
      ..registerAdapter<Address>(AddressAdapter())
      ..registerAdapter<Geo>(GeoAdapter())
      ..registerAdapter<Company>(CompanyAdapter())
      ..registerAdapter<Post>(PostAdapter())
      ..registerAdapter<Album>(AlbumAdapter())
      ..registerAdapter<Photo>(PhotoAdapter())
      ..registerAdapter<Comment>(CommentAdapter());

    await Hive.openBox<User>('userBox');
    await Hive.openBox<Post>('postBox');
    await Hive.openBox<Album>('albumBox');
    await Hive.openBox<Photo>('photoBox');
    await Hive.openBox<Comment>('commentBox');
  }
}
