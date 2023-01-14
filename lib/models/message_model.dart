import 'package:chatapp/widgets/constants.dart';

class Message {
  final String message;
  final String id;
  // constructor of class Message
  Message(this.message, this.id);

  // factory Constructor to accept data form jsonData
  factory Message.fromjson(jsonData) {
    return Message(jsonData[KMessage], jsonData['id']);
  }
}
