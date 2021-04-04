import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:books_app/Pages/chat.dart';
import 'package:books_app/Pages/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class ChatsList extends StatefulWidget {
  TextEditingController searchBarController;
  Function dismissSearchBar;

  ChatsList(TextEditingController controller, Function function) {
    this.searchBarController = controller;
    this.dismissSearchBar = function;
  }

  @override
  _ChatsListState createState() =>
      _ChatsListState(searchBarController, dismissSearchBar);
}

class _ChatsListState extends State<ChatsList> {
  TextEditingController searchBarController;
  Function dismissSearchBar;
  List<Chat> chats, shownList;
  bool loading;

  _ChatsListState(TextEditingController controller, Function function) {
    this.searchBarController = controller;
    this.dismissSearchBar = function;
    loading = true;
  }

  getChats() async {
    Response res = await get(
        "https://textbooks.azurewebsites.net/PHP%20API/Get%20Chats.php?email=${UserDetails.email}");
    if (res.body != "[EMPTY]") {
      List<dynamic> jsonList = jsonDecode(res.body);
      for (int i = 0; i < jsonList.length; i++) {
        chats.insert(
            0,
            Chat(
                id: jsonList[i][0],
                user1: jsonList[i][1],
                user2: jsonList[i][2],
                status: int.parse(jsonList[i][3]),
                bookID: int.parse(jsonList[i][4]),
                bookTitle: jsonList[i][5],
                bookImage: jsonList[i][6]));
      }
    }
    if (this.mounted)
      setState(() {
        loading = false;
        shownList.addAll(chats);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shownList = [];
    chats = [];
    getChats();
    searchBarController.addListener(() {
      String text = searchBarController.text;
      shownList.clear();
      for (int i = 0; i < chats.length; i++) {
        String otherUser = (chats[i].user1 == UserDetails.name)
            ? chats[i].user2
            : chats[i].user1;
        if (otherUser.toLowerCase().contains(text.toLowerCase()) ||
            chats[i].bookTitle.toLowerCase().contains(text.toLowerCase())) {
          shownList.add(chats[i]);
        }
      }
      if (this.mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading)
      return Container(
        color: Colors.white,
        child: SpinKitCircle(
          color: Color(0xFFB67777),
          size: 70,
        ),
      );
    else if (UserDetails.email == "anon")
      return Center(
        child: Container(
          child: Text("Please sign in to be able to buy books."),
        ),
      );
    else if (chats.isEmpty)
      return Center(
        child: Container(
          child: Text("You have not started any chats."),
        ),
      );
    else
      return RefreshIndicator(
        color: Color(0xFFB67777),
        onRefresh: () async {
          shownList = [];
          chats = [];
          await getChats();
          dismissSearchBar();
          searchBarController.addListener(() {
            String text = searchBarController.text;
            shownList.clear();
            for (int i = 0; i < chats.length; i++) {
              String otherUser = (chats[i].user1 == UserDetails.name)
                  ? chats[i].user2
                  : chats[i].user1;
              if (otherUser.toLowerCase().contains(text.toLowerCase()) ||
                  chats[i]
                      .bookTitle
                      .toLowerCase()
                      .contains(text.toLowerCase())) {
                shownList.add(chats[i]);
              }
            }
            if (this.mounted) setState(() {});
          });
        },
        child: Container(
            child: ListView.builder(
                itemCount: shownList.length,
                itemBuilder: (context, index) {
                  return ChatCard(shownList[index], dismissSearchBar);
                })),
      );
  }
}

class ChatCard extends StatelessWidget {
  Chat chat;
  Function dismissSearchBar;
  String otherUser;

  ChatCard(Chat chat, Function function) {
    this.chat = chat;
    this.dismissSearchBar = function;
    otherUser = (chat.user1 == UserDetails.name) ? chat.user2 : chat.user1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          dismissSearchBar.call();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ChatPage(
                      chat.id, otherUser, chat.bookID, chat.bookTitle)));
        },
        child: Card(
          elevation: 0,
          child: Container(
            height: 95,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5)),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 12, 5),
                child: Container(
                  child: Container(
                    width: 50,
                    height: 80,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF804A4A), width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(chat.bookImage),
                      )),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "With ${chat.user1 == UserDetails.name ? chat.user2 : chat.user1}",
                      style: TextStyle(fontSize: 14, color: Color(0xFF706161)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 12, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            "Book: ${chat.bookTitle}",
                            maxFontSize: 22,
                            maxLines: 2,
                            minFontSize: 20,
                            style: TextStyle(color: Color(0xFF706161)),
                          ),
                          Image(
                            image: AssetImage("assets/images/arrow_icon.png"),
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Color(0xFF706161),
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Status: ",
                            ),
                            TextSpan(
                              style: TextStyle(
                                  color: (chat.status == 0
                                      ? Colors.orange[800]
                                      : (chat.status == 1
                                          ? Colors.green[500]
                                          : Colors.red)),
                                  fontWeight: FontWeight.bold),
                              text: (chat.status == 0
                                  ? "Pending"
                                  : (chat.status == 1 ? "Sold" : "Cancelled")),
                            )
                          ]),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
