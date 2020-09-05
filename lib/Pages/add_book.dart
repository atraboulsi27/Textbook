import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBook createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = new TextEditingController();
  TextEditingController courseNameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  File _image;
  final picker = ImagePicker();
  int dropdownValue = 1;

  _imgFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  _imgFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  insert_book(
      String title, String author, String description, String price) async {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);
    String filename = UserDetails.email + " " + date.toIso8601String() + ".jpg";
    String newPath = path.join(path.dirname(_image.path), filename);
    _image.renameSync(newPath);
    FTPConnect ftpConnect = FTPConnect('ftp.3dbeirut.com',
        user: 'textbooks_app@3dbeirut.com', pass: 'Geranimo542533');
    File fileToUpload = File(newPath);
    DateTime _date = new DateTime(now.year, now.month, now.day);
    String dateToBeInserted = _date.toIso8601String();
    String sellerEmail = UserDetails.email;
    String sellerName = UserDetails.name;
    String mysqlImagePath =
        "http://khaled.3dbeirut.com/Textbooks%20App/Images/" + filename;
    bool res =
        await ftpConnect.uploadFileWithRetry(fileToUpload, pRetryCount: 2);
    if (res) {
      try {
        Response res1 = await get(
            "http://khaled.3dbeirut.com/Textbooks%20App/Scripts/Insert%20Book.php?title=$title&author=$author&description=$description&date=$dateToBeInserted&price=$price&image=$mysqlImagePath&seller_email=$sellerEmail&seller_name=$sellerName");
        if (res1.body == "[SUCCESS]") {
          return true;
        } else
          return false;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Widget Price(TextEditingController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.monetization_on,
              color: Color(0xFF804A4A),
              size: 30,
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                  8, 2, 0,
                  MediaQuery.of(context).size.height *
                      0.1 /
                      3, // HERE THE IMPORTANT PART
                ),
                border: OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(0)),
                    borderSide: BorderSide(color: Color(0xFFA07070))),
                hintText: ("Price"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: DropdownButton(
                value: dropdownValue,
                items: [
                  DropdownMenuItem(
                    child: Text("L.L"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("\$"),
                    value: 2,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                }),
          ),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFB67777)),
        centerTitle: true,
        title: Text(
          "Add Book",
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 20,
              ),
              field(Icons.book, titleController, "Book Title", context),
              field(Icons.edit, authorController, "Author's Names", context),
              field(FontAwesomeIcons.graduationCap, courseNameController,
                  "Course Name", context),
              field(Icons.description, descriptionController,
                  "Description(ex. Condition, Edition, etc..)", context),
              Price(priceController, context),
              button(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String price;
          dropdownValue == 1
              ? price = priceController.text + " L.L"
              : price = priceController.text + " \$";
          insert_book(titleController.text, authorController.text,
              descriptionController.text, price);
        },
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: _image != null
          ? const EdgeInsets.fromLTRB(0, 10, 0, 30)
          : const EdgeInsets.all(0),
      child: Row(
        crossAxisAlignment: _image != null
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.image,
              color: Color(0xFF804A4A),
              size: 30,
            ),
          ),
          _image == null
              ? OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () => _showPicker(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Upload Cover Photo",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Hexcolor("#B67777")),
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 130,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_image), fit: BoxFit.fill),
                            border:
                                Border.all(color: Color(0xFF804A4A), width: 4),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(3, 3))
                            ])),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Color(0xFFA07070),
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });
                      },
                    )
                  ],
                ),
        ],
      ),
    );
  }
}

Widget field(IconData icon, TextEditingController controller,
    String placeholder, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            icon,
            color: Color(0xFF804A4A),
            size: 30,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width / 1.4,
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                8, 2, 0,
                MediaQuery.of(context).size.height *
                    0.1 /
                    3, // HERE THE IMPORTANT PART
              ),
              border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(0)),
                  borderSide: BorderSide(color: Color(0xFFA07070))),
              hintText: placeholder,
            ),
          ),
        )
      ],
    ),
  );
}
