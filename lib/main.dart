import 'package:books_app/Pages/drawer.dart';

import 'Pages/add_book.dart';
import 'Pages/books_list.dart';
import 'Pages/chats.dart';
import 'package:books_app/Login/Login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Textbooks App',
      home: Switch(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Widget Switch() {
  bool loggedIn = false; //firebase code to check if signed in or not
  if (loggedIn)
    return Home();
  else
    return Login();
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  Map<int, Widget> pageMap = {0: BooksList(), 1: AddBook(), 2: ChatList()};
  Map<int, String> titleMap = {0: "Text Books", 1: "Add Book", 2: "Chats"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFB67777)),
        centerTitle: true,
        title: Text(
          titleMap[currentIndex],
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
        actions: [
          Icon(
            Icons.search,
          ),
          Container(
            width: 20,
          )
        ],
        bottom: PreferredSize(
          child: Container(
            color: Color(0xFFB67777),
            height: 2,
          ),
        ),
      ),
      drawer: Drawer(
        child: BookDrawer(context),
      ),
      body: pageMap[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFA07070),
        fixedColor: Colors.white,
        unselectedItemColor: Color(0x60FFFFFF),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(title: Text("Books"), icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              title: Text("Add Book"), icon: Icon(Icons.add)),
          BottomNavigationBarItem(
              title: Text("Chats"), icon: Icon(Icons.chat_bubble)),
        ],
      ),
    );
  }
}
