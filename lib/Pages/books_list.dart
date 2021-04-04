import 'dart:convert';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'classes.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    Response res = await post(Uri.https("nodejs-api.azurewebsites.net", "/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"command": "GET_BOOK"}));
    if (jsonDecode(res.body)["rowsAffected"][0] != 0) {
      List<dynamic> jsonList = jsonDecode(res.body)["recordsets"][0];
      for (int i = 0; i < jsonList.length; i++) {
        books.insert(
            0,
            Book(
                id: jsonList[i]["ID"].toString(),
                title: jsonList[i]["Title"],
                author: jsonList[i]["Author"],
                description: jsonList[i]["Description"],
                date: jsonList[i]["Date"],
                price: jsonList[i]["Price"],
                image: jsonList[i]["Image"],
                sellerEmail: jsonList[i]["SellerEmail"],
                sellerName: jsonList[i]["SellerName"]));
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
        "https://textbooks.azurewebsites.net/PHP%20API/Get%20Chats.php?email=${UserDetails.email}");
    if (res.body != "[EMPTY]") {
      List<dynamic> jsonList = jsonDecode(res.body);
      String toAdd = "";
      for (int i = 0; i < jsonList.length; i++) {
        if (jsonList[i][7] == UserDetails.email)
          toAdd = jsonList[i][8];
        else
          toAdd = jsonList[i][7];
        if (!startedChats.contains(toAdd))
          startedChats.add(StartedChats(title: jsonList[i][5], email: toAdd));
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

//  final RefreshController _refreshController = RefreshController();

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
      return RefreshIndicator(
        color: Color(0xFFB67777),
        onRefresh: () async {
          shownList = [];
          books = [];
          await getList();
          dismissSearchBar();
          searchBarController.addListener(() async {
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
