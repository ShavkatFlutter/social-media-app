import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentButton extends StatefulWidget {
  final String text;
  final String user;
  final String time;
  final String postID;
  final String commentID;
  const CommentButton({
    super.key,
    required this.text,
    required this.user,
    required this.time,
    required this.postID,
    required this.commentID,
  });

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
