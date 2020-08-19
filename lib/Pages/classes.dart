class Book{
  String title, author, date, price, image;
  Book({this.title, this.author, this.date, this.price, this.image});
}

class Chat{
  String id, buyer, seller;
  int status;
  Book book;
  Chat({this.id, this.buyer, this.seller, this.status, this.book});
}