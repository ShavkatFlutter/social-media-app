import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_messager/others/button.dart';
import 'package:social_messager/others/helper.dart';
import 'package:social_messager/others/text_field.dart';

class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

      if(context.mounted) Navigator.pop(context);
    }
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
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
                const Text("Login your account"),
                const SizedBox(height: 20),
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
                GestureDetector(
                  child: const SignButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  onTap: signIn,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(width: 50),
                    GestureDetector(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      onTap: widget.onTap,
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
