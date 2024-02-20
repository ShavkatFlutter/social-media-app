import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  final userName;
  final userID;

  const ChatPage({super.key, required this.userName, required this.userID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(widget.userName, style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundImage: AssetImage("lib/images/avatar.jpeg")),
          ),
        ],
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(20.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Send message",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
