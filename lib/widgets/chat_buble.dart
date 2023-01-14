import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/widgets/constants.dart';
import 'package:flutter/material.dart';

//chatBubble for Me
class Chatbuble extends StatelessWidget {
  const Chatbuble({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 18, right: 18, bottom: 23, top: 23),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
          color: kPrimaryColor,
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            height: 1.3,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// chatBubble For Friend
class ChatbubleForFriend extends StatelessWidget {
  const ChatbubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 18, right: 18, bottom: 23, top: 23),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
              bottomLeft: Radius.circular(35)),
          color: Color(0xff006D84),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            height: 1.3,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
