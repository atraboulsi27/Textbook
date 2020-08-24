import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'book_details.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Book {
  String title, author, date, price, image, sellerEmail, sellerName;

  Book({this.title, this.author, this.date, this.price, this.image, this.sellerEmail, this.sellerName});
}

class Chat {
  String id, buyer, seller;
  int status;
  Book book;

  Chat({this.id, this.buyer, this.seller, this.status, this.book});
}

class BookCard extends StatelessWidget {
  Book book;
  Function dismissSearchBar;

  BookCard(Book book, Function function) {
    this.book = book;
    this.dismissSearchBar = function;
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
                  builder: (BuildContext context) => BookDetails(book)));
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
