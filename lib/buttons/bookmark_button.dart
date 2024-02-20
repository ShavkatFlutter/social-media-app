import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarkButton extends StatelessWidget {
  final void Function()? onTap;
  final bool bookmark;
  const BookmarkButton({super.key, required this.onTap, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        bookmark ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
        size: 20,
        color: bookmark ? Colors.blue : Colors.grey,
      ),
    );
  }
}
