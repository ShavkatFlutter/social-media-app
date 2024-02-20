import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_messager/others/message_bubble.dart';
import 'package:social_messager/pages/Messages/contacts.dart';

import '../chat_page.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ContactsPage()));
        },
        backgroundColor: Colors.indigoAccent,
        shape: const CircleBorder(),
        child: const Icon(Icons.send, color: Colors.white),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList());
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_firebaseAuth.currentUser!.email != data["email"]) {
      return MessageBubble(
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                  backgroundImage: AssetImage("lib/images/avatar.jpeg")),
              title: Text(data["name"]),
              subtitle: Text(data["email"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      userName: data["name"],
                      userID: data["uid"],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
