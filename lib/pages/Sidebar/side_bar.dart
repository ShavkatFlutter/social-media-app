import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../user/user_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}


Widget buildHeader(BuildContext context) => Material(
  color: Colors.indigoAccent,
  child: InkWell(
    onTap: (){
      Navigator.of(context);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const UserPage()));
    },
    child: Container(
      padding: EdgeInsets.only(
        top: 10 + MediaQuery.of(context).padding.top,
        bottom: 20,
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.cyanAccent,
            backgroundImage: AssetImage("lib/images/avatar.jpeg"),
          ),
          const SizedBox(height: 10),
          Text(FirebaseAuth.instance.currentUser!.email.toString(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),
        ],
      ),
    ),
  ),
);

Widget buildMenuItems(BuildContext context) => Container(
  padding: const EdgeInsets.all(15),
  child: Wrap(
    runSpacing: 15,
    children: [
      ListTile(
        leading: const Icon(Icons.home, color: Colors.indigoAccent),
        title: const Text("Home"),
        onTap: (){
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.person_rounded, color: Colors.indigoAccent),
        title: const Text("Profile"),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings, color: Colors.indigoAccent),
        title: const Text("Settings"),
        onTap: (){},
      ),
      ListTile(
        leading: const Icon(Icons.bookmark, color: Colors.indigoAccent),
        title: const Text("Bookmarks"),
        onTap: (){},
      ),
    ],
  ),
);
