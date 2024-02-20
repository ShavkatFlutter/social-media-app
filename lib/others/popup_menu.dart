import 'package:flutter/material.dart';

class PopupButton extends StatelessWidget {
  const PopupButton({super.key});

  final String item1 = "Follow";
  final String item2 = "Mute";
  final String item3 = "Block";
  final String item4 = "Report";

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.grey[300],
      iconColor: Colors.grey,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Text(item1),
              const SizedBox(width: 15),
              const Icon(Icons.person_add),
            ],
          ),
          onTap: () {},
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Text(item2),
              const SizedBox(width: 15),
              const Icon(Icons.volume_off_outlined),
            ],
          ),
          onTap: () {},
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Text(item3),
              const SizedBox(width: 15),
              const Icon(Icons.block),
            ],
          ),
          onTap: () {},
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Text(item4),
              const SizedBox(width: 15),
              const Icon(Icons.report_problem_outlined),
            ],
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
