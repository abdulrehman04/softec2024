import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:softec_app/models/post_model.dart';

class PostsRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<bool> createPost({
    String caption = '',
    required File file,
    required String uid,
    required String name,
    required String profileImage,
  }) async {
    try {
      final task = await _storage
          .ref()
          .child(DateTime.now().toIso8601String())
          .putFile(file);

      String link = await task.ref.getDownloadURL();
      await _db.collection('posts').add({
        'caption': caption,
        'uid': uid,
        'name': name,
        'image': profileImage,
        'imageLink': link,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Post>> fetchAllPosts() async {
    QuerySnapshot data = await _db.collection('posts').get();
    List<Post> posts = List.from(
      data.docs.map(
        (element) => Post.fromMap(element.data()! as Map<String, dynamic>),
      ),
    );

    print(posts);
    return posts;
  }
}
