import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instragram_flutter/models/post.dart';
import 'package:instragram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(String desciption, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occurd";
    try {
      String photoUrl =
          await StorageMethods().uploadImageStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: desciption,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        proImage: profImage,
        likes: [],
      );
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List like) async {
    try {
      if (like.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> postComment(String postId, String uid, String text,
      String profilePic, String name) async {
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'postId': postId,
          'profilePic': profilePic,
          'username': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'likes': [],
        });
        print("success");
      } else {
        print("Text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> likeComment(
      String postId, String uid, String commentId, List like) async {
    try {
      if (like.contains(uid)) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayUnion([uid]),
        });
        print("hellow else");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
