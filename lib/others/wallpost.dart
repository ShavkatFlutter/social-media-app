import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_messager/buttons/comment.dart';
import 'package:social_messager/buttons/like_button.dart';
import 'package:social_messager/buttons/repost_button.dart';
import 'package:social_messager/others/helper/popup_current_user.dart';
import 'package:social_messager/others/message_bubble.dart';
import 'package:social_messager/others/popup_menu.dart';
import 'package:social_messager/others/reply_message.dart';
import 'package:social_messager/pages/post_page/selected_post.dart';

import '../buttons/bookmark_button.dart';

const TextStyle style = TextStyle(color: Colors.black54);

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postID;
  final List<String> likes;

  const WallPost({
    Key? key,
    required this.message,
    required this.user,
    required this.time,
    required this.likes,
    required this.postID,
  }) : super(key: key);

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  bool reposted = false;
  bool bookmark = false;
  bool commented = false;
  int commentCount = 0;
  int bookmarkCount = 0;
  int repostCount = 0;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
    fetchCommentCount();
  }

  void fetchCommentCount() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postID)
        .collection("Comments")
        .get();

    setState(() {
      commentCount = snapshot.size;
    });
  }

  Future<void> toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection("User Posts").doc(widget.postID);

    if (isLiked) {
      postRef.update({
        "Likes": FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      postRef.update({
        "Likes": FieldValue.arrayRemove([currentUser.email]),
      });
    }
    if(commented){
      postRef.update({
        "Comments": FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      postRef.update({
        "Comments": FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postID)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now(),
    });

    // Increment comment count
    setState(() {
      commentCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MessageBubble(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectedPost(
                      message: widget.message,
                      user: widget.user,
                      time: widget.time,
                      postID: widget.postID,
                      likes: widget.likes,
                    ),
                  ),
                );
              },
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: const CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                  backgroundImage: AssetImage("lib/images/avatar.jpeg"),
                ),
                title: Row(
                  children: [
                    Expanded(child: Text(widget.user, style: style)),
                    const Text(" . ", style: style),
                    Row(
                      children: [
                        Text(widget.time, style: style),
                        if (widget.user != currentUser.email)
                          const PopupButton()
                        else
                          const PopupForCurrentUser(),
                      ],
                    ),
                  ],
                ),
                subtitle: Text(
                  widget.message,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Comment button to comment and reply to the post
                Row(
                  children: [
                    CommentButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReplyPage(),
                            ),
                          );
                        },
                        commented: commented),
                    const SizedBox(width: 5),
                    Text(commentCount.toString()),
                  ],
                ),

                // Repost button re-shares selected post
                Row(
                  children: [
                    RepostButton(
                      onTap: () {
                        setState(() {
                          reposted = !reposted;
                          repostCount++;
                        });
                      },
                      reposted: reposted,
                    ),
                    SizedBox(width: 5),
                    Text(repostCount.toString()),
                  ],
                ),

                // Like button
                Row(
                  children: [
                    LikeButton(onTap: toggleLike, isLiked: isLiked),
                    const SizedBox(width: 5),
                    Text(widget.likes.length.toString()),
                  ],
                ),

                //Bookmark button saves post to bookmark list
                Row(
                  children: [
                    BookmarkButton(
                      onTap: () {
                        setState(() {
                          bookmark = !bookmark;
                          bookmarkCount++;
                        });
                      },
                      bookmark: bookmark,
                    ),
                    const SizedBox(width: 5),
                    Text(bookmarkCount.toString()), // Display comment count
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
