import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String hint;
  final String label;

  const InputButton({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
