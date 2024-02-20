import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _message = 'No Notification yet';

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) {
      print("Firebase token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _message = message.notification?.body ?? 'No message body';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Notification:',
          ),
        ),
        Text(
          _message,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
