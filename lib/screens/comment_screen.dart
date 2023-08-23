import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instragram_flutter/models/user.dart';
import 'package:instragram_flutter/providers/user_provider.dart';
import 'package:instragram_flutter/resources/firestore_methods.dart';
import 'package:instragram_flutter/utils/colors.dart';
import 'package:instragram_flutter/widgets/comment_cart.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text("Comments"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .snapshots(),
          // builder: (context, snapshot) {
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print("item number here");
              print((snapshot.data! as dynamic).docs.length);
            }
            return ListView.builder(
              shrinkWrap: true,
              // this is chip treack ..you can use asynchronussnapshot
              // itemCount: (snapshot.data! as dynamic).docs.length,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => CommentCard(
                snap: (snapshot.data! as dynamic).docs[index],
              ),
            );
          },
        ),
        // body: CommentCard(),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: const EdgeInsets.only(bottom: 10.0),
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoUrl),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      maxLines: 5,
                      controller: _textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "comment as ${user.username}",
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await FirestoreMethods().postComment(
                        widget.snap['postId'],
                        user.uid,
                        _textController.text,
                        user.photoUrl,
                        user.username);
                    _textController.clear();
                  },
                  child: Container(
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
