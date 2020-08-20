import 'package:flutter/material.dart';
import 'classes.dart';



class BooksList extends StatelessWidget {
  final List books = [
    Book(
        title: "The Arsonist",
        author: "Chris Hooper",
        date: "22 June",
        price: "15 \$",
        image: "http://khaled.3dbeirut.com/Download%20Files/arsonist.png"),
    Book(
        title: "The King of Drugs The King of Drugs The King of Drugs The King of Drugs",
        author: "Nora Barrett Nora Barrett Nora Barrett Nora Barrett Nora Barrett",
        date: "July 31",
        price: "150 \$",
        image: "http://khaled.3dbeirut.com/Download%20Files/test.jpg"),
    Book(
        title: "The Gravity of Us",
        author: "Khaled Jalloul",
        date: "July 31",
        price: "150 \$",
        image: "http://khaled.3dbeirut.com/Download%20Files/test2.jpg"),
    Book(
        title: "The Arsonist",
        author: "Khaled Jalloul",
        date: "July 31",
        price: "150 \$",
        image: "http://khaled.3dbeirut.com/Download%20Files/arsonist.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(books[index]);
            }));
  }
}


