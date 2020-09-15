import 'dart:convert';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'classes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  List<StartedChats> startedChats;
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
        books.insert(
            0,
            Book(
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
    startedChats = [];
    await getChats();
    if (this.mounted)
      setState(() {
        loading = false;
        shownList.addAll(books);
      });
  }

  getChats() async {
    Response res = await get(
        "http://khaled.3dbeirut.com/Textbooks%20App/Scripts/Get%20Chats.php?email=${UserDetails.email}");
    if (res.body != "[EMPTY]") {
      List<dynamic> jsonList = jsonDecode(res.body);
      String toAdd = "";
      for (int i = 0; i < jsonList.length; i++) {
        if (jsonList[i][6] == UserDetails.email)
          toAdd = jsonList[i][7];
        else
          toAdd = jsonList[i][6];
        if (!startedChats.contains(toAdd))
          startedChats.add(StartedChats(title: jsonList[i][4], email: toAdd));
      }
    }
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

  final RefreshController _refreshController = RefreshController();

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
      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(),
        onRefresh: () async {
          setState(() {
            shownList = [];
            books = [];
            getList();
            searchBarController.addListener(() {
              String text = searchBarController.text;
              shownList.clear();
              for (int i = 0; i < books.length; i++) {
                if (books[i].title.toLowerCase().contains(text.toLowerCase()) ||
                    books[i]
                        .author
                        .toLowerCase()
                        .contains(text.toLowerCase())) {
                  shownList.add(books[i]);
                }
              }
              if (this.mounted) setState(() {});
            });
          });
          _refreshController.refreshCompleted();

        },
        child: Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: shownList.length,
                itemBuilder: (context, index) {
                  return BookCard(shownList[index], dismissSearchBar,
                      changePage, startedChats);
                })),
      );
  }
}
