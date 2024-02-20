import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_messager/others/helper/util.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final textController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        "UserName": currentUser.displayName,
        "UserEmail": currentUser.email,
        "Message": textController.text,
        "TimeStamp": Timestamp.now(),
        "Likes": [],
      });

      setState(() {
        setState(() {
          textController.clear();
        });
        Navigator.pop(context);
      });
    }
  }

  List<File> images = [];

  void onPickImages() async {
    setState(() async {
      images = await pickImage(ImageSource.camera);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          ElevatedButton(
            onPressed: postMessage,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor:
                  Colors.indigoAccent, // Set your desired button color here
            ),
            child: Text(
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
                CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                  backgroundImage: AssetImage("lib/images/avatar.jpeg"),
                  radius: 25,
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 300,
                  child: TextField(
                    maxLines: null,
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: "What is happening?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (images.isNotEmpty)
            CarouselSlider(
              items: images.map((file) => Image.file(file)).toList(),
              options: CarouselOptions(
                height: 400,
                enableInfiniteScroll: false,
              ),
            ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.multitrack_audio,
                color: Colors.blue,
              )),
          IconButton(
              onPressed: onPickImages,
              icon:
                  Icon(Icons.add_photo_alternate_outlined, color: Colors.blue)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.gif_box_outlined, color: Colors.blue)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.location_on_outlined, color: Colors.blue)),
        ],
      ),
    );
  }
}
