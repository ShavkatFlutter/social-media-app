import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_messager/others/button.dart';
import 'package:social_messager/others/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../others/helper.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpwController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    if (_passwordController.text != _confirmpwController.text) {
      Navigator.pop(context);

      displayMessageToUser("Passwords don't match", context);
    } else {
      try {
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        addUserDetails(
          _nameController.text.trim(),
          _emailController.text.trim(),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        displayMessageToUser(e.code, context);
      }
    }
  }

  Future addUserDetails(String name, String email) async {
    await FirebaseFirestore.instance.collection("users").add({
      'name': name,
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.message, size: 89, color: Colors.indigoAccent),
                const SizedBox(height: 30),
                const Text("Register here"),
                const SizedBox(height: 20),
                InputButton(
                  obscureText: false,
                  controller: _nameController,
                  hint: "Enter your name",
                  label: "Name",
                ),
                const SizedBox(height: 15),
                InputButton(
                  obscureText: false,
                  controller: _emailController,
                  hint: "Enter email",
                  label: "Email",
                ),
                const SizedBox(height: 15),
                InputButton(
                  obscureText: true,
                  controller: _passwordController,
                  hint: "Password",
                  label: "Password",
                ),
                const SizedBox(height: 15),
                InputButton(
                  obscureText: true,
                  controller: _confirmpwController,
                  hint: "Confirm password",
                  label: "Confirm",
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: signUp,
                  child: const SignButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Already have account?"),
                    const SizedBox(width: 50),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Sign in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
