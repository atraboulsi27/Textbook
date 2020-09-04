import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBook createState() => _AddBook();

}

class _AddBook extends State<AddBook> {

  @override
  TextEditingController title_controller = new TextEditingController();
  TextEditingController author_controller = new TextEditingController();
  TextEditingController course_name_controller = new TextEditingController();
  TextEditingController description_controller = new TextEditingController();
  TextEditingController price_controller = new TextEditingController();
  File _image;
  final picker = ImagePicker();

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
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
        }
    );
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
      body: Container(
        child: Column(
          children: [
            Container(
              height: 20,
            ),
            field(Icons.book, title_controller, "Book Title", context),
            field(Icons.edit, author_controller, "Author's Names", context),
            field(Icons.calendar_today, course_name_controller, "Course Name",
                context),
            field(Icons.monetization_on, description_controller, "Description",
                context),
            field(Icons.description, price_controller, "Price", context),
            button(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.image,
            color: Color(0xFF804A4A),
            size: 30,
          ),
        ),
        OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          onPressed: () => _showPicker(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("Upload Cover Photo"),
          ),
        ),
      ],
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
            textAlign: TextAlign.start,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(0),
                  ),
                  borderSide: BorderSide()),
              hintText: placeholder,
            ),
          ),
        )
      ],
    ),
  );
}
