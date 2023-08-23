import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final String postUrl;
  final String proImage;
  final likes;
  final datePublished;

  Post({
    required this.uid,
    required this.username,
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.proImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "proImage": proImage,
        "likes": likes,
      };

  Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data()! as Map<String, dynamic>;
    return Post(
      uid: snapshot['uid'],
      username: snapshot['username'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      proImage: snapshot['proImage'],
      likes: snapshot['likes'],
    );
  }
}
