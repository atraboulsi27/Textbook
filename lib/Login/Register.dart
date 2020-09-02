import 'package:auto_size_text/auto_size_text.dart';
import 'package:books_app/Helper Classes/Authentication.dart';
import 'package:books_app/Helper Classes/user_details.dart';
import 'package:books_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  Authentication auth = Authentication();
  TextEditingController nameController,
      emailController,
      passController,
      cpassController;
  GlobalKey<FormState> formKey;
  String status;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    cpassController = TextEditingController();
    status = "";
  }

  Widget loadingError() {
    if (status == "")
      return Container();
    else if (status == "loading")
      return SpinKitCircle(
        color: Colors.white,
        size: 30,
      );
    else
      return Center(
        child: Container(
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color(0xAAFFFFFF)),
            width: MediaQuery.of(context).size.width / 1.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.error,
                      size: 20,
                      color: Colors.red[400],
                    ),
                    AutoSizeText(
                      status,
                      minFontSize: 15,
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/books_wallpaper.png"),
                fit: BoxFit.cover)),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 18,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: RawMaterialButton(
                  padding: EdgeInsets.all(8),
                  //do
                  constraints: BoxConstraints(),
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Display Name",
                          style: TextStyle(
                              fontFamily: 'selawk',
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Container(
                          width: 301,
                          height: 75,
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              helperText: ' ',
                              filled: true,
                              fillColor: Hexcolor("#FFFFFF"),
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Hexcolor("#707070"),
                                  )),
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Field can\'t be empty.';
                              else
                                return null;
                            },
                          ),
                        ),
                      ),
                    ]),
              ),
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontFamily: 'selawk',
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Container(
                          height: 75,
                          width: 301,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              helperText: ' ',
                              filled: true,
                              fillColor: Hexcolor("#FFFFFF"),
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Hexcolor("#707070"),
                                  )),
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Field can\'t be empty.';
                              else
                                return null;
                            },
                          ),
                        ),
                      ),
                    ]),
              ),
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontFamily: 'selawk',
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Container(
                          height: 75,
                          width: 301,
                          child: TextFormField(
                            controller: passController,
                            obscureText: true,
                            decoration: InputDecoration(
                              helperText: ' ',
                              filled: true,
                              fillColor: Hexcolor("#FFFFFF"),
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Hexcolor("#707070"),
                                  )),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Field can\'t be empty.';
                              } else if (value.length < 6)
                                return "Password must be 6 or more characters";
                              else
                                return null;
                            },
                          ),
                        ),
                      ),
                    ]),
              ),
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Confirm Password",
                          style: TextStyle(
                              fontFamily: 'selawk',
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Container(
                          height: 75,
                          width: 301,
                          child: TextFormField(
                            controller: cpassController,
                            obscureText: true,
                            decoration: InputDecoration(
                              helperText: ' ',
                              filled: true,
                              fillColor: Hexcolor("#FFFFFF"),
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Hexcolor("#707070"),
                                  )),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Field can\'t be empty.';
                              } else if (value.length < 6)
                                return "Password must be 6 or more characters";
                              else if (passController.text.trim() !=
                                  cpassController.text.trim())
                                return "Passwords do not match";
                              else
                                return null;
                            },
                          ),
                        ),
                      ),
                    ]),
              ),
              loadingError(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Hexcolor("#707070"))),
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 29),
                    color: Hexcolor("#E6D3D3").withOpacity(0.54),
                    onPressed: () async {
                      setState(() {
                        status = "";
                      });
                      if (formKey.currentState.validate()) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          status = "loading";
                        });
                        String result = await auth.register(
                            emailController.text.trim(),
                            nameController.text.trim(),
                            passController.text.trim());
                        if (result.contains("[USER]")) {
                          UserDetails.setUserDetails(
                              result.replaceAll("[USER]", ""));
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        } else {
                          setState(() {
                            status = result;
                          });
                        }
                      }
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontFamily: 'selawk',
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
