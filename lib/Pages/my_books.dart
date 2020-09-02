import 'dart:convert';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:books_app/Pages/add_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'classes.dart';

class MyBooks extends StatefulWidget {
  TextEditingController searchBarController;
  Function dismissSearchBar;

  MyBooks(TextEditingController controller, Function function) {
    this.searchBarController = controller;
    this.dismissSearchBar = function;
  }

  @override
  _MyBooksState createState() =>
      _MyBooksState(searchBarController, dismissSearchBar);
}

class _MyBooksState extends State<MyBooks> {
  TextEditingController searchBarController;
  Function dismissSearchBar;
  List<Book> books, shownList;
  bool loading = true;

  _MyBooksState(TextEditingController controller, Function function) {
    this.searchBarController = controller;
    this.dismissSearchBar = function;
  }

  getList() async {
    Response res = await get(
        "http://khaled.3dbeirut.com/Textbooks%20App/Scripts/Get%20My%20Books.php?email=${UserDetails.email}");
    if (res.body != "[EMPTY]") {
      List<dynamic> jsonList = jsonDecode(res.body);
      for (int i = 0; i < jsonList.length; i++) {
        books.add(Book(
            id: jsonList[i][0],
            title: jsonList[i][1],
            author: jsonList[i][2],
            date: jsonList[i][3],
            price: jsonList[i][4],
            image: jsonList[i][5],
            sellerEmail: jsonList[i][6],
            sellerName: jsonList[i][7]));
      }
    }
    if (this.mounted)
      setState(() {
        loading = false;
        shownList.addAll(books);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shownList = [];
    books = [];
    if (UserDetails.email != "anon")
      getList();
    else
      loading = false;
    searchBarController.addListener(() {
      String text = searchBarController.text;
      shownList.clear();
      for (int i = 0; i < books.length; i++) {
        if (books[i].title.toLowerCase().contains(text.toLowerCase()) ||
            books[i].author.toLowerCase().contains(text.toLowerCase())) {
          shownList.add(books[i]);
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
          child: Text("Please sign in to be able to list your books."),
        ),
      );
    else if (books.isEmpty)
      return Center(
        child: Container(
          child: Text("You have not put any books for sale."),
        ),
      );
    else
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView.builder(
              itemCount: shownList.length,
              itemBuilder: (context, index) {
                return BookCard(shownList[index], dismissSearchBar);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Icon(
              Icons.add,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3)),
          ),
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddBook()));
          },
        ),
      );
  }
}
