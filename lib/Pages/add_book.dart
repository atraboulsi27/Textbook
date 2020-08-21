import 'package:flutter/material.dart';
import 'classes.dart';

class AddBook extends StatefulWidget {
  TextEditingController searchBarController;
  Function dismissSearchBar;

  AddBook(TextEditingController controller, Function function) {
    this.searchBarController = controller;
    this.dismissSearchBar = function;
  }

  @override
  _AddBookState createState() =>
      _AddBookState(searchBarController, dismissSearchBar);
}

class _AddBookState extends State<AddBook> {
  TextEditingController searchBarController;
  Function dismissSearchBar;
  List<Book> books, shownList;

  _AddBookState(TextEditingController controller, Function function) {
    this.searchBarController = controller;
    this.dismissSearchBar = function;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shownList = [];
    books = [
      Book(
          title: "The Arsonist",
          author: "Chris Hooper",
          date: "22 June",
          price: "15 \$",
          image: "http://khaled.3dbeirut.com/Download%20Files/arsonist.png"),
      Book(
          title:
              "The King of Drugs The King of Drugs The King of Drugs The King of Drugs",
          author:
              "Nora Barrett Nora Barrett Nora Barrett Nora Barrett Nora Barrett",
          date: "July 31",
          price: "150 \$",
          image: "http://khaled.3dbeirut.com/Download%20Files/test.jpg"),
    ];
    shownList.addAll(books);
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
        onPressed: () {},
      ),
    );
  }
}
