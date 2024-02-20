import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final Widget child;
  const SignButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.indigoAccent,
      ),
      child: Center(child: child),
    );
  }
}
