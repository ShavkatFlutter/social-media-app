import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  final void Function()? onTap;
  final bool commented;
  const CommentButton(
      {super.key, required this.onTap, required this.commented});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(CupertinoIcons.chat_bubble, size: 20, color: Colors.grey),
    );
  }
}


// final String text;
// final String user;
// final String time;
//
// required this.text,
// required this.user,
// required this.time