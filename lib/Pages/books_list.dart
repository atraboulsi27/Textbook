import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'classes.dart';
import 'package:books_app/main.dart';

class BooksList extends StatefulWidget {
  TextEditingController searchBarController;
  Function dismissSearchBar, changePage;

  BooksList(TextEditingController controller, Function dismissSearchBar,
      Function changePage) {
    this.searchBarController = controller;
    this.dismissSearchBar = dismissSearchBar;
    this.changePage = changePage;
  }

  @override
  _BooksListState createState() =>
      _BooksListState(searchBarController, dismissSearchBar, changePage);
}

class _BooksListState extends State<BooksList> {
  TextEditingController searchBarController;
  Function dismissSearchBar, changePage;
  List<Book> books, shownList;
  bool loading = true;

  _BooksListState(TextEditingController controller, Function dismissSearchBar,
      Function changePage) {
    this.searchBarController = controller;
    this.dismissSearchBar = dismissSearchBar;
    this.changePage = changePage;
  }

  getList() async {
    Response res = await get(
        "http://khaled.3dbeirut.com/Textbooks%20App/Scripts/Get%20Books.php");
    if (res.body != "[EMPTY]") {
      List<dynamic> jsonList = jsonDecode(res.body);
      for (int i = 0; i < jsonList.length; i++) {
        books.add(Book(
            id: jsonList[i][0],
            title: jsonList[i][1],
            author: jsonList[i][2],
            description: jsonList[i][3],
            date: jsonList[i][4],
            price: jsonList[i][5],
            image: jsonList[i][6],
            sellerEmail: jsonList[i][7],
            sellerName: jsonList[i][8]));
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
    getList();
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
    else if (books.isEmpty)
      return Center(
        child: Container(
          child: Text("There are no books currently for sale."),
        ),
      );
    else
      return Container(
          color: Colors.white,
          child: ListView.builder(
              itemCount: shownList.length,
              itemBuilder: (context, index) {
                return BookCard(shownList[index], dismissSearchBar, changePage);
              }));
  }
}
