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
import '../../buttons/bookmark_button.dart';
import '../../others/helper/format_date.dart';
import '../Messages/comment_bubble.dart';

const TextStyle style = TextStyle(color: Colors.black54);

class SelectedWall extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postID;
  final List<String> likes;

  const SelectedWall({
    super.key,
    required this.message,
    required this.user,
    required this.time,
    required this.likes,
    required this.postID,
  });

  @override
  State<SelectedWall> createState() => _SelectedWall();
}

class _SelectedWall extends State<SelectedWall> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  bool reposted = false;
  bool bookmark = false;
  bool commented = false;
  int commentCount = 0;
  int bookmarkCount = 0;

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

  void repostIcon() {
    setState(() {
      reposted = !reposted;
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



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        MessageBubble(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
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
                ),
                Text(
                  widget.message,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        CommentButton(onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReplyPage()));
                        }, commented: commented),
                        const SizedBox(width: 5),
                        Text(commentCount.toString()),
                      ],
                    ),
                    RepostButton(
                      onTap: () {
                        setState(() {
                          reposted = !reposted;
                        });
                      },
                      reposted: reposted,
                    ),
                    Row(
                      children: [
                        LikeButton(onTap: toggleLike, isLiked: isLiked),
                        SizedBox(width: 5),
                        Text(widget.likes.length.toString()),
                      ],
                    ),
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
                        SizedBox(width: 5),
                        Text(bookmarkCount.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("User Posts")
              .doc(widget.postID)
              .collection("Comments")
              .orderBy("CommentTime", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data!.docs.map((doc) {
                final commentData = doc.data() as Map<String, dynamic>;
                return CommentBubble(
                  text: commentData["CommentText"],
                  user: commentData["CommentedBy"],
                  time: formatData(commentData["CommentTime"]),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
