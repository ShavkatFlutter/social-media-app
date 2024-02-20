import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../others/helper/format_date.dart';
import '../../others/wallpost.dart';

class UserPosts extends StatelessWidget {
  UserPosts({super.key});

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .where("UserEmail", isEqualTo: currentUser.email)
                  .orderBy("TimeStamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post["Message"],
                          user: post["UserEmail"],
                          time: formatData(post["TimeStamp"]),
                          postID: post.id,
                          likes: List<String>.from(post["Likes"] ?? []),
                        );
                      });
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ],
    );
  }
}
