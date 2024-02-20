import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_messager/pages/post_page/selected_wall.dart';

import '../../others/helper/format_date.dart';

class SelectedPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postID;
  final List<String> likes;
  const SelectedPost({
    super.key,
    required this.message,
    required this.user,
    required this.time,
    required this.postID,
    required this.likes,
  });

  @override
  State<SelectedPost> createState() => _SelectedPostState();
}

class _SelectedPostState extends State<SelectedPost> {
  final _commentTextController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Post"),
        backgroundColor: Colors.grey[300],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User Posts")
              .orderBy("TimeStamp", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> posts = snapshot.data!.docs;
              final selectedPosts = posts.where((post) => post.id == post.id);
              if (selectedPosts.isNotEmpty) {
                final selectedPost = selectedPosts.first;
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return SelectedWall(
                      message: selectedPost["Message"],
                      user: selectedPost["UserEmail"],
                      time: formatData(selectedPost["TimeStamp"]),
                      postID: selectedPost.id,
                      likes: List<String>.from(selectedPost["Likes"] ?? []),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("Post not found"),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: _commentTextController,
                decoration: const InputDecoration(
                  hintText: "Post your reply",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  addComment(_commentTextController.text);
                  _commentTextController.clear();
                },
                icon: const Icon(Icons.send,
                    size: 30, color: Colors.indigoAccent)),
          ],
        ),
      ),
    );
  }
}
