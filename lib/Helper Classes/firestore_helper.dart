import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

class FirestoreHelper {
  String id;
  CollectionReference ref = Firestore.instance.collection("Chats");

  FirestoreHelper({this.id});

  createChat(String user1, String user2, String bookID) async {
    DocumentReference newDoc = await ref.add({"Chat": []});
    String chatID = newDoc.id;
    Response res = await get(
        "http://khaled.3dbeirut.com/Textbooks%20App/Scripts/Create%20Chat.php?chatID=$chatID&user1=$user1&user2=$user2&bookID=${int.parse(bookID)}");
    if (res.body == "[SUCCESS]")
      print("yay");
    else
      print("nay");
  }

  sendMessage(
      String user, String message, List<String> chat, String chatID) async {
    chat.add("$user[SENT]$message");
    await ref.doc(chatID).update({
      "Chat": chat,
    });
  }

  Stream<Map<String, dynamic>> get chat {
    return ref.doc(id).snapshots().map((event) {
      return event.data();
    });
  }
}
