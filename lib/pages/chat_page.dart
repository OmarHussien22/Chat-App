import 'package:chatapp/widgets/chat_buble.dart';
import 'package:chatapp/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message_model.dart';

class ChatScreen extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //ModelRoute to accept email from login of arguments
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    KLogo,
                    height: 65,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(children: [
              Expanded(
                  child: ListView.builder(
                      reverse: true,
                      // ordered By message of last message
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: ((context, index) {
                        return messagesList[index].id == email
                            ? Chatbuble(message: messagesList[index])
                            : ChatbubleForFriend(message: messagesList[index]);
                      }))),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: controller,
                  onSubmitted: (data) {
                    messages.add({
                      KMessage: data,
                      // ordered By message of time
                      'createdAt': DateTime.now(),
                      'id': email,
                    });
                    controller.clear();
                    _controller.animateTo(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: Container(
                        child: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: kPrimaryColor))),
                ),
              )
            ]),
          );
        } else {
          return Text('Loading');
        }
      },
    );
  }
}
