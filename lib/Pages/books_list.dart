import 'package:books_app/Pages/book_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        title: "The King of Drugs",
        author: "Nora Barrett",
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

class BookCard extends StatelessWidget {
  Book book;

  BookCard(Book book) {
    this.book = book;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> BookDetails(book)));
        },
        child: Card(
          elevation: 0,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5)),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 3, 8, 3),
                child: Container(
                  child: Container(
                    width: 90
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF804A4A), width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(book.image),
                    )
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      book.title,
                      style:
                          TextStyle(fontSize: 22, color: Color(0xFF706161)),
                    ),
                    Text(
                      book.author,
                      style:
                          TextStyle(fontSize: 12, color: Color(0xFF706161)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Image(
                          image: AssetImage("assets/images/arrow_icon.png"),
                          height: 50,
                        ),
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Color(0xFF706161),
                      thickness: 2,
                      endIndent: 10,
                    ),
                    Text(
                      book.date,
                      style:
                          TextStyle(fontSize: 12, color: Color(0xFF706161)),
                    ),
                    Text(
                      book.price,
                      style:
                          TextStyle(fontSize: 21, color: Color(0xFF706161)),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
