// import 'package:cloud_firestore/cloud_firestore.dart';
//
// String formatData(Timestamp timestamp){
//
//   DateTime now = DateTime.now();
//   DateTime dataTime = timestamp.toDate();
//
//   String year = dataTime.year.toString();
//   String month = dataTime.month.toString();
//   String day = dataTime.day.toString();
//   String hours = dataTime.hour.toString();
//   String formattedData = "$day/$month/$year";
//
//   return formattedData;
// }

import 'package:cloud_firestore/cloud_firestore.dart';

String formatData(Timestamp timestamp) {
  DateTime now = DateTime.now();
  DateTime messageTime = timestamp.toDate();

  Duration difference = now.difference(messageTime);

  if (difference.inDays > 0) {

    return '${difference.inDays} d${difference.inDays == 1 ? "" : ""}';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} h${difference.inHours == 1 ? "" : ""}';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} m${difference.inMinutes == 1 ? '' : ''}';
  }
  else if (difference.inDays > 6) {
    return messageTime.toString();
  }
  else {
    return 'now';
  }
}