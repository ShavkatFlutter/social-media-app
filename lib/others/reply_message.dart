import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ReplyPage extends StatefulWidget {
  const ReplyPage({super.key});

  @override
  State<ReplyPage> createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  final replyController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor:
              Colors.indigoAccent, // Set your desired button color here
            ),
            child: const Text(
              "Send",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                  backgroundImage: AssetImage("lib/images/avatar.jpeg"),
                  radius: 25,
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 300,
                  child: TextField(
                    maxLines: null,
                    controller: replyController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: "Post reply",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}