import 'package:books_app/main_body.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFB67777)),
        centerTitle: true,
        title: Text(
          "Text Books",
          style: TextStyle(
              letterSpacing: 2,
              color: Color(0xFFB67777),
              fontFamily: "Segoe UI",
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
        child: Container(),
      ),
      body: MainBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFA07070),
        fixedColor: Colors.white,
        unselectedItemColor: Color(0x60FFFFFF),
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Books"),
            icon: Icon(
              Icons.list
            )
          ),
          BottomNavigationBarItem(
              title: Text("Add Book"),
              icon: Icon(
                  Icons.add
              )
          ),
          BottomNavigationBarItem(
              title: Text("Chats"),
              icon: Icon(
                  Icons.chat_bubble
              )
          ),
        ],
      ),
    );
  }
}
