import 'package:books_app/Helper%20Classes/firestore_helper.dart';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatPage extends StatefulWidget {
  String id, otherUser, bookName;

  ChatPage(id, otherUser, bookName) {
    this.id = id;
    this.otherUser = otherUser;
    this.bookName = bookName;
  }

  @override
  _ChatPageState createState() => _ChatPageState(id, otherUser, bookName);
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController;
  ScrollController scrollController;
  List<MessageBox> messages;
  List<Widget> messageRows;
  String id, otherUser, bookName;

  _ChatPageState(id, otherUser, bookName) {
    this.id = id;
    this.otherUser = otherUser;
    this.bookName = bookName;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageController = TextEditingController();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFB67777)),
        centerTitle: true,
        title: Text(
          "Chat",
          style: TextStyle(
              letterSpacing: 2,
              color: Color(0xFFB67777),
              fontFamily: "selawk",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(1, 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: Color(0xFFB67777),
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          otherUser,
                          style: TextStyle(color: Color(0xFFB67777)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.book,
                          size: 20,
                          color: Color(0xFFB67777),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          bookName,
                          style: TextStyle(color: Color(0xFFB67777)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                color: Color(0xFFB67777),
                height: 2,
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: FirestoreHelper(id: id).chat,
          builder: (context, snapshot) {
            Map<String, dynamic> chatMap = snapshot.data;
            if (chatMap != null) {
              List<String> chat = List<String>.from(chatMap["Chat"]);
              messages = [];
              for (String messageElement in chat) {
                if (messageElement.isNotEmpty) {
                  String sender = messageElement.substring(
                      0, messageElement.indexOf("[SENT]"));
                  if (sender == UserDetails.name) sender = "[YOU]";
                  String message = messageElement
                      .substring(messageElement.indexOf("[SENT]") + 6);
                  messages.add(MessageBox(
                      sender,
                      Row(
                        mainAxisAlignment: (sender == "[YOU]")
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75),
                            child: Card(
                              color: (sender == "[YOU]")
                                  ? Colors.grey[300]
                                  : Colors.green[200],
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(message),
                              ),
                            ),
                          )
                        ],
                      )));
                }
              }
              if (messages.isNotEmpty)
                Future.delayed(Duration(milliseconds: 50), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
              messageRows = [];
              for (int i = 0; i < messages.length; i++) {
                messageRows.add(messages[i].row);
              }
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: messages.isEmpty
                            ? Center(
                                child:
                                    Text("Send a message to start the chat!"))
                            : SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: messageRows,
                                ),
                              ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              autocorrect: false,
                              controller: messageController,
                              decoration: InputDecoration(
                                labelText: "Message",
                                labelStyle: TextStyle(color: Color(0xFFB67777)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFB67777), width: 2)),
                              ),
                              cursorColor: Color(0xFFB67777),
                              onTap: () {
                                if (messages.isNotEmpty)
                                  Future.delayed(Duration(milliseconds: 50),
                                      () {
                                    scrollController.animateTo(
                                        scrollController
                                            .position.maxScrollExtent,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeOut);
                                  });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: IconButton(
                              icon: Icon(
                                Icons.send,
                                size: 30,
                                color: Color(0xFFB67777),
                              ),
                              onPressed: () {
                                if (messageController.text.trim() != "") {
                                  FirestoreHelper().sendMessage(
                                      UserDetails.name,
                                      messageController.text.trim(),
                                      chat,
                                      id);
                                }
                                setState(() {
                                  messageController.clear();
                                });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: SpinKitCircle(
                  color: Color(0xFFB67777),
                  size: 70,
                ),
              );
            }
          }),
    );
  }
}

class MessageBox {
  String sender;
  Widget row;

  MessageBox(sender, row) {
    this.sender = sender;
    this.row = row;
  }
}
