import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentBubble extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const CommentBubble(
      {super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: const Border(
          bottom: BorderSide(
            width: 0.1,
          )
        )
      ),
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("lib/images/avatar.jpeg"),
            ),
            title: Text(user, style: TextStyle(color: Colors.grey)),
            subtitle:
                Text(text, style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(CupertinoIcons.chat_bubble, size: 20, color: Colors.grey),
                  SizedBox(width: 5),
                  Text("0"),
                ],
              ),

              // Repost button re-shares selected post
              Row(
                children: [
                  Icon(Icons.repeat, color: Colors.grey, size: 20),
                  SizedBox(width: 5),
                  Text("0"),
                ],
              ),

              // Like button
              Row(
                children: [
                  Icon(Icons.favorite_border, color: Colors.grey, size: 20),
                  SizedBox(width: 5),
                  Text("0"),
                ],
              ),

              //Bookmark button saves post to bookmark list
              Row(
                children: [
                  Icon(Icons.bookmark_border, color: Colors.grey, size: 20),
                  SizedBox(width: 5),
                  Text("0"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
