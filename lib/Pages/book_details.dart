import 'package:books_app/Pages/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BookDetails extends StatelessWidget {
  Book book;

  BookDetails(Book book) {
    this.book = book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFB67777)),
        centerTitle: true,
        title: Text(
          "Book Details",
          style: TextStyle(
              letterSpacing: 2,
              color: Color(0xFFB67777),
              fontFamily: "selawk",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Color(0xFFB67777),
            height: 2,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(book.image),
                        fit: BoxFit.fill),
                    border: Border.all(color: Color(0xFF804A4A), width: 4),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(3, 3))
                    ]),
                child: Container(
                  height: 200,
                  width: 130,
                ),
              ),
            ),
            Label(Icons.book, book.title, context),
            Label(Icons.edit, book.author, context),
            Label(Icons.calendar_today, book.date, context),
            Label(Icons.monetization_on, book.price, context),
            Label(Icons.description, "Description?", context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Icon(
            Icons.add_shopping_cart,
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

Widget Label(IconData icon, String info, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            icon,
            color: Color(0xFF804A4A),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: AutoSizeText(
            info,
            maxFontSize: 22,
            minFontSize: 17,
            maxLines: 5,
            style: TextStyle(
              color: Color(0xFF804A4A),
            ),
          ),
        )
      ],
    ),
  );
}
