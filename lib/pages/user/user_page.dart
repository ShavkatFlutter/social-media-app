import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_messager/others/helper/util.dart';
import 'package:social_messager/pages/user/user_posts.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  Uint8List? _image;
  late TabController _tabController;
  final currentUser = FirebaseAuth.instance.currentUser!;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.indigoAccent,
                          backgroundImage: AssetImage("lib/images/avatar.jpeg"),
                        ),
                  Positioned(
                    top: 60,
                    left: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        color: Colors.indigo,
                        child: IconButton(
                          onPressed: (){}, //selectImage,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                currentUser.email.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Followers",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Following",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Joined in: " +
                        currentUser.metadata.creationTime
                            .toString()
                            .substring(0, 10),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Posts"),
                Tab(text: 'Replies'),
                Tab(text: 'Likes'),
              ],
              labelStyle: TextStyle(fontSize: 17),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Content of Tab 1
                  UserPosts(),
                  // Content of Tab 2
                  const Center(
                    child: Text(
                      "Replies",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Likes",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
