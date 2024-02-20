import 'package:flutter/material.dart';

class PopupForCurrentUser extends StatelessWidget {
  const PopupForCurrentUser({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.grey[300],
      iconColor: Colors.grey,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Delete post",
                  style: TextStyle(color: Colors.red)),
              SizedBox(width: 15),
              Icon(Icons.delete_forever_outlined,
                  color: Colors.red),
            ],
          ),
          onTap: () {},
        ),
        PopupMenuItem(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Edit"),
              SizedBox(width: 15),
              Icon(Icons.edit),
            ],
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
