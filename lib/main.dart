import 'package:books_app/Helper%20Classes/Authentication.dart';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:books_app/Login/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Pages/drawer.dart';
import 'Pages/my_books.dart';
import 'Pages/books_list.dart';
import 'Pages/chats_list.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Textbooks App',
      home: Loading(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    launch(context);
    return Container(
      color: Colors.white,
      child: SpinKitCircle(
        size: 70,
        color: Color(0xFFA07070),
      ),
    );
  }
}

launch(context) async {
  Authentication auth = Authentication();
  String email = await auth.currentUser();
  if (email != null) {
    if (email.isNotEmpty) {
      UserDetails.setUserDetails(email);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Home()));
    } else
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login()));
  } else
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  Map<int, Widget> pageMap;
  Map<int, String> titleMap = {0: "Text Books", 1: "My Books", 2: "Chats"};
  IconData appBarIcon;
  Widget appBarContent, appBarText, appBarField;
  TextEditingController appBarController;

  setAppBar() {
    appBarText = Text(
      titleMap[currentIndex],
      style: TextStyle(
          letterSpacing: 2,
          color: Color(0xFFB67777),
          fontFamily: "selawk",
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
    );
    appBarField = TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Search for " + (currentIndex == 2 ? "chat..." : "book..."),
        hintStyle: TextStyle(
          fontFamily: "selawk",
        ),
      ),
      cursorColor: Color(0xFFB67777),
      style: TextStyle(
          color: Color(0xFFB67777), fontFamily: "selawk", fontSize: 17),
      controller: appBarController,
      autofocus: false,
    );
    appBarIcon = Icons.search;
    appBarContent = appBarText;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarController = TextEditingController();
    Function dismissSearchBar = () {
      setState(() {
        appBarIcon = Icons.search;
        appBarContent = appBarText;
        appBarController.clear();
      });
    };
    pageMap = {
      0: BooksList(appBarController, dismissSearchBar),
      1: MyBooks(appBarController, dismissSearchBar),
      2: ChatsList(appBarController, dismissSearchBar)
    };
    setAppBar();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFB67777)),
        centerTitle: true,
        title: appBarContent,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              appBarIcon,
            ),
            onPressed: () {
              setState(() {
                if (appBarIcon == Icons.search) {
                  appBarIcon = Icons.cancel;
                  appBarContent = appBarField;
                } else if (appBarIcon == Icons.cancel) {
                  appBarIcon = Icons.search;
                  appBarContent = appBarText;
                  appBarController.clear();
                }
              });
            },
          ),
          Container(
            width: 20,
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 2),
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
            setAppBar();
            appBarController.clear();
          });
        },
        items: [
          BottomNavigationBarItem(title: Text("Books"), icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              title: Text("My Books"), icon: Icon(Icons.book)),
          BottomNavigationBarItem(
              title: Text("Chats"), icon: Icon(Icons.chat_bubble)),
        ],
      ),
    );
  }
}
