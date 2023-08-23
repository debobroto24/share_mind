import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  User({
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
  // to take documentsnapshot and return model.user
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data()! as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      username: snapshot['username'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
