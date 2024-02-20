
import 'package:flutter/material.dart';
import 'package:social_messager/pages/register_and_login/register.dart';
import 'login.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage =true;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  void toggleScreens (){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: toggleScreens);
    }
    else {
      return RegisterPage(onTap: toggleScreens);
    }
  }
}