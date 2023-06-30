import 'package:mongo_dart/mongo_dart.dart';

class Message {
  final ObjectId? id;
  final String? message;
  final String? senderUsername;
  final DateTime? sentAt;

  Message({
    this.id,
    this.message,
    this.senderUsername,
    this.sentAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'message': message,
      'senderUsername': senderUsername,
      'sentAt': sentAt,
    };
  }

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      message: message['message'],
      senderUsername: message['senderUsername'],
      sentAt: DateTime.fromMillisecondsSinceEpoch(message['sentAt']),
    );
  }
}
