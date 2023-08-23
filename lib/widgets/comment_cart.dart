import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instragram_flutter/providers/user_provider.dart';
import 'package:instragram_flutter/resources/firestore_methods.dart';
import 'package:instragram_flutter/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
// import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;

  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    // return Scaffold(
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.snap['username']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '  ${widget.snap['text']}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Text(
                          DateFormat.yMMMd().format(
                            widget.snap['datePublished'].toDate(),
                          ),
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "${widget.snap['likes'].length} people Likes",
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: LikeAnimation(
              isAnimating: true,
              smallLike: true,
              child: IconButton(
                onPressed: () async {
                  await FirestoreMethods().likeComment(widget.snap['postId'],
                      user.uid, widget.snap['commentId'], widget.snap['likes']);
                },
                icon: widget.snap['likes'].contains(user.uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border),
              ),
            ),
          ),
        ],
      ),
    );
    // );
  }
}
