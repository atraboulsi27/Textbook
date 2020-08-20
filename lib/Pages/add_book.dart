import 'package:flutter/material.dart';
import 'classes.dart';

class AddBook extends StatelessWidget {
  @override
  final List books = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(books[index]);
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
