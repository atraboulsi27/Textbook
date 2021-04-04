import 'package:books_app/Helper%20Classes/firestore_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'classes.dart';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BookDetails extends StatefulWidget {
  Book book;
  Function changePage;
  List<StartedChats> chatEmails;

  BookDetails(Book book, Function changePage, List<StartedChats> chatEmails) {
    this.book = book;
    this.changePage = changePage;
    this.chatEmails = chatEmails;
  }

  @override
  _BookDetailsState createState() =>
      _BookDetailsState(book, changePage, chatEmails);
}

class _BookDetailsState extends State<BookDetails> {
  bool loading;
  Book book;
  Function changePage;
  List<StartedChats> startedChats;

  _BookDetailsState(
      Book book, Function changePage, List<StartedChats> chatEmails) {
    this.book = book;
    this.changePage = changePage;
    this.startedChats = chatEmails;
    loading = false;
  }

  String fabCondition() {
    if (book.sellerEmail == UserDetails.email)
      return "mybook";
    else if (UserDetails.email == "anon")
      return "none";
    else {
      for (int i = 0; i < startedChats.length; i++) {
        if (startedChats[i].title == book.title &&
            startedChats[i].email == book.sellerEmail) {
          print("test");
          return "none";
        }
      }
      return "purchase";
    }
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
                          image: CachedNetworkImageProvider(widget.book.image),
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
                    height: 230,
                    width: 130,
                  ),
                ),
              ),
              Label(Icons.book, book.title, context),
              Label(Icons.edit, book.author, context),
              Label(Icons.calendar_today, book.date, context),
              Label(Icons.monetization_on, book.price, context),
              Label(Icons.description, book.description, context),
            ],
          ),
        ),
        floatingActionButton: fabCondition() == "none"
            ? Container()
            : (fabCondition() == "purchase")
                ? FloatingActionButton(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      child: loading
                          ? SpinKitCircle(
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.add_shopping_cart,
                            ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 3)),
                    ),
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            elevation: 10,
                            title: Text(
                              "Request to buy this book from ${book.sellerName}?",
                              style: TextStyle(
                                color: Color(0xFFA07070),
                                fontFamily: 'selawk',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Divider(
                                    color: Color(0xFFB67777),
                                    thickness: 2,
                                  ),
                                  Text(
                                    "This will start a chat where you can discuss details about the purchase.\n\nYou can chat here or share your phone numbers for ease.\n\nMake sure you do not share many details and meet in public places.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlatButton(
                                        child: new Text("Cancel",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16)),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      FlatButton(
                                        child: new Text(
                                          "Start Chat",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).then((value) async {
                        if (value != null) {
                          if (value) {
                            setState(() {
                              loading = true;
                            });
                            bool result = await FirestoreHelper().createChat(
                                book.sellerName,
                                UserDetails.name,
                                book.id,
                                book.title,
                                book.image,
                                book.sellerEmail,
                                UserDetails.email);
                            if (result) {
                              setState(() {
                                loading = false;
                              });
                              Navigator.of(context).pop();
                              changePage(2);
                            } else {
                              setState(() {
                                loading = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    elevation: 10,
                                    title: Text(
                                      "Error",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'selawk',
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                      "An unexpected error has occurred. Please try again.",
                                      style: TextStyle(
                                        color: Color(0xFFA07070),
                                        fontFamily: 'selawk',
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(
                                            color: Color(0xFFB67777),
                                            fontSize: 17,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        }
                      });
                    },
                  )
                : FloatingActionButton(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      child: loading
                          ? SpinKitCircle(
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.delete_forever,
                            ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 3)),
                    ),
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            elevation: 10,
                            title: Text(
                              "Confirm Delete",
                              style: TextStyle(
                                color: Color(0xFFA07070),
                                fontFamily: 'selawk',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Container(
                              height: MediaQuery.of(context).size.height / 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Divider(
                                    color: Color(0xFFB67777),
                                    thickness: 2,
                                  ),
                                  Text(
                                    "Are you sure you want to remove this book? It will no longer be available for people to purchase.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlatButton(
                                        child: new Text("Cancel",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16)),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      FlatButton(
                                        child: new Text(
                                          "Delete book",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).then((value) async {
                        if (value != null) {
                          if (value) {
                            // setState(() {
                            //   loading = true;
                            // });
                            // bool result = await FirestoreHelper().createChat(
                            //     book.sellerName,
                            //     UserDetails.name,
                            //     book.title,
                            //     book.image,
                            //     book.sellerEmail,
                            //     UserDetails.email);
                            // if (result) {
                            //   setState(() {
                            //     loading = false;
                            //   });
                            //   Navigator.of(context).pop();
                            //   changePage(2);
                            // } else {
                            //   setState(() {
                            //     loading = false;
                            //   });
                            //   showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         contentPadding: EdgeInsets.symmetric(
                            //             vertical: 10, horizontal: 20),
                            //         elevation: 10,
                            //         title: Text(
                            //           "Error",
                            //           style: TextStyle(
                            //             color: Colors.red,
                            //             fontFamily: 'selawk',
                            //             fontSize: 17,
                            //           ),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //         content: Text(
                            //           "An unexpected error has occurred. Please try again.",
                            //           style: TextStyle(
                            //             color: Color(0xFFA07070),
                            //             fontFamily: 'selawk',
                            //             fontSize: 15,
                            //           ),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //         actions: [
                            //           FlatButton(
                            //             child: Text(
                            //               "Ok",
                            //               style: TextStyle(
                            //                 color: Color(0xFFB67777),
                            //                 fontSize: 17,
                            //               ),
                            //             ),
                            //             onPressed: () {
                            //               Navigator.of(context).pop();
                            //             },
                            //           )
                            //         ],
                            //       );
                            //     },
                            //   );
                            // }
                          }
                        }
                      });
                    },
                  ));
  }
}

Widget Label(IconData icon, String info, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
