import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'book_class.dart';

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
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Container(
            height: 160,
            child: Card(
              elevation: 0,
              child: Container(
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Container(
                      child: Image(
                        image: CachedNetworkImageProvider(book.image),
                        width: 90,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF804A4A), width: 5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          child: Image(
                            image: AssetImage("assets/images/arrow_icon.png"),
                            height: 50,
                          ),
                        ),
                        Divider(
                          height: 10,
                          color: Color(0xFF706161),
                          thickness: 2,
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
        ),
      ),
    );
  }
}