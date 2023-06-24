import 'package:mongo_dart/mongo_dart.dart';
import 'package:model/message.dart';
import '../utils/constants.dart';

class MongoDatabase {
  static var db, messageCollection;

  static connect() async {
    final db = Db('mongodb://localhost:27017/message');
        await db.open();
    messageCollection = db.collection(MESSAGE_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final messages = await messageCollection.find().toList();
      return messages;
    } catch (e) {
      print(e);
      return Future.value(e);
    }
  }

  static insert(Message message) async {
    await messageCollection.insertAll([message.toMap()]);
  }

  static update(Message message) async {
    var msg = await messageCollection.findOne({"_id": message.id});
    msg["message"] = message.message;
    msg["senderUsername"] = message.senderUsername;
    msg["sentAt"] = message.sentAt;
    await messageCollection.save(msg);
  }

  static delete(Message message) async {
    await messageCollection.remove(where.id(message.id));
  }
}