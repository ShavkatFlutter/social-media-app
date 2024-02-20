import 'package:flutter/material.dart';

class RepostButton extends StatelessWidget {
  final void Function()? onTap;
  final bool reposted;
  const RepostButton({super.key, required this.onTap, required this.reposted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(reposted ? Icons.repeat : Icons.repeat, size: 20, color: reposted ? Colors.green : Colors.grey),
    );
  }
}
