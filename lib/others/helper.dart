import 'package:flutter/material.dart';

displayMessageToUser(String message, BuildContext context){
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
  );
}