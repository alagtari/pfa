import 'package:flutter/cupertino.dart';

class ChatUser {
  String name;
  String secondaryText;
  String image;
  String time;

  int id_conv;
  ChatUser(
      {required this.id_conv,
      required this.name,
      required this.secondaryText,
      required this.image,
      required this.time});
}
