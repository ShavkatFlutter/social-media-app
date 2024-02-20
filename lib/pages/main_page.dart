import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Messages/messages.dart';
import 'Notifications/notification.dart';
import 'Sidebar/side_bar.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  void logout(){
    FirebaseAuth.instance.signOut();
  }
  int _currentIndex = 0;
  List<Widget> item =  [
    HomePage(),
    NotificationPage(),
    MessagesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Mini twitter", style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(onPressed: logout,
                icon: Icon(Icons.logout, color: Colors.black,),
            ),
          ],
          backgroundColor: Colors.indigoAccent,
        ),
        body: item[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          selectedFontSize: 16,
          unselectedItemColor: Colors.grey[300],
          selectedIconTheme: IconThemeData(size: 30),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.indigoAccent,
          currentIndex: _currentIndex,
          onTap: (int newIndex){
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home, color: Colors.grey[300]),
            ),
            BottomNavigationBarItem(
              label: "Notifications",
              icon: Icon(Icons.notifications_outlined, color: Colors.grey[300]),
            ),
            BottomNavigationBarItem(
              label: "Messages",
              icon: Icon(Icons.email, color: Colors.grey[300]),
            ),
          ],
        ),
        drawer: NavBar(),
      ),
    );
  }
}