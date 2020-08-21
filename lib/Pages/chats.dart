import 'package:books_app/Pages/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  TextEditingController searchBarController;
  Function dismissSearchBar;

  ChatList(TextEditingController controller, Function function) {
    this.searchBarController = controller;
    this.dismissSearchBar = function;
  }

  @override
  _ChatListState createState() => _ChatListState(searchBarController, dismissSearchBar);
}

class _ChatListState extends State<ChatList> {
  TextEditingController searchBarController;
  Function dismissSearchBar;
  List<Chat> chats, shownList;

  _ChatListState(TextEditingController controller, Function function) {
    this.searchBarController = controller;
    this.dismissSearchBar = function;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chats = [
      Chat(
        id: "B37",
        buyer: "Khaled Jalloul",
        seller: "Ahmad Traboulsi",
        status: 0,
        book: Book(
            title: "The King of Drugs",
            author: "Nora Barrett",
            date: "July 31",
            price: "150 \$",
            image: "http://khaled.3dbeirut.com/Download%20Files/test.jpg"),
      ),
      Chat(
        id: "B37",
        buyer: "Khaled Jalloul",
        seller: "Ahmad Traboulsi",
        status: 1,
        book: Book(
            title: "The Gravity of Us",
            author: "Khaled Jalloul",
            date: "July 31",
            price: "150 \$",
            image: "http://khaled.3dbeirut.com/Download%20Files/test2.jpg"),
      ),
      Chat(
        id: "B37",
        buyer: "Khaled Jalloul",
        seller: "Ahmad Traboulsi",
        status: 2,
        book: Book(
            title: "The Arsonist",
            author: "Khaled Jalloul",
            date: "July 31",
            price: "150 \$",
            image: "http://khaled.3dbeirut.com/Download%20Files/arsonist.png"),
      ),
    ];
    shownList = [];
    shownList.addAll(chats);
    searchBarController.addListener(() {
      String text = searchBarController.text;
      shownList.clear();
      for (int i = 0; i < chats.length; i++) {
        if (chats[i].buyer.toLowerCase().contains(text.toLowerCase()) ||
            chats[i].seller.toLowerCase().contains(text.toLowerCase()) ||
            chats[i].book.title.toLowerCase().contains(text.toLowerCase())) {
          shownList.add(chats[i]);
        }
      }
      if (this.mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: shownList.length,
            itemBuilder: (context, index) {
              return ChatCard(shownList[index], dismissSearchBar);
            }));
  }
}

class ChatCard extends StatelessWidget {
  Chat chat;
  Function dismissSearchBar;

  ChatCard(Chat chat, Function function) {
    this.chat = chat;
    this.dismissSearchBar = function;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          dismissSearchBar.call();
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
                        image: CachedNetworkImageProvider(chat.book.image),
                      )),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "With ${chat.seller}",
                      style: TextStyle(fontSize: 14, color: Color(0xFF706161)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 12, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Book: ${chat.book.title}",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFF706161)),
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
