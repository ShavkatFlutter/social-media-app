import 'package:flutter/material.dart';
import 'package:social_messager/others/message_bubble.dart';

class PostDesign extends StatelessWidget {
  final String name;
  final String email;
  final String post;

  const PostDesign({
    super.key,
    required this.name,
    required this.email,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageBubble(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("lib/images/avavar.jpeg"),
            ),
            title: Text(name),
            subtitle: Text(email),
          ),
        ),
        const SizedBox(height: 10),
        Text(post),
        const SizedBox(height: 10),
        const Row(
          children: [
            Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 5),
                Text("0"),
              ],
            ),

            // Repost button re-shares selected post
            Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 5),
                Text("0"),
              ],
            ),

            // Like button
            Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 5),
                Text("0"),
              ],
            ),

            //Bookmark button saves post to bookmark list
            Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 5),
                Text("0"),
              ],
            ),
          ],
        )
      ],
    );
  }
}
