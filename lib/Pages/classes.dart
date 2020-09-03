import 'package:books_app/Pages/book_details.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Book {
  String id, title, author, date, price, image, sellerEmail, sellerName;

  Book(
      {this.id,
      this.title,
      this.author,
      this.date,
      this.price,
      this.image,
      this.sellerEmail,
      this.sellerName});
}

class Chat {
  String id, user1, user2, bookTitle, bookImage;
  int status;

  Chat(
      {this.id,
      this.user1,
      this.user2,
      this.status,
      this.bookTitle,
      this.bookImage});
}

class BookCard extends StatelessWidget {
  Book book;
  Function dismissSearchBar, changePage;

  BookCard(Book book, Function dismissSearchBar, Function changePage) {
    this.book = book;
    this.dismissSearchBar = dismissSearchBar;
    this.changePage = changePage;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BookDetails(book, changePage)));
          dismissSearchBar.call();
        },
        child: Card(
          elevation: 0,
          child: Container(
            height: 170,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5)),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 3, 8, 3),
                child: Container(
                  child: Container(width: 90),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF804A4A), width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(book.image),
                      )),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AutoSizeText(
                      book.title,
                      maxFontSize: 22,
                      maxLines: 2,
                      minFontSize: 16,
                      style: TextStyle(color: Color(0xFF706161)),
                    ),
                    AutoSizeText(
                      book.author,
                      maxLines: 1,
                      maxFontSize: 12,
                      style: TextStyle(color: Color(0xFF706161)),
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
                      style: TextStyle(fontSize: 12, color: Color(0xFF706161)),
                    ),
                    Text(
                      book.price,
                      style: TextStyle(fontSize: 21, color: Color(0xFF706161)),
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
