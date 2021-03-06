import 'package:books_app/Helper%20Classes/Authentication.dart';
import 'package:books_app/Helper%20Classes/user_details.dart';
import 'package:books_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Register.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController, passController;
  GlobalKey<FormState> formKey;
  String status;
  Authentication auth = Authentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    status = "";
    emailController = new TextEditingController();
    passController = new TextEditingController();
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
      return Row( //to wrap container around content
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Color(0xAAFFFFFF)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      size: 20,
                      color: Colors.red[400],
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    AutoSizeText(
                      status,
                      minFontSize: 15,
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/books_wallpaper.png"),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 6,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Center(
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
                ),
                loadingError(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
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
                          String result = await auth.signIn(
                              emailController.text.trim(),
                              passController.text.trim());
                          if (result.contains("[USER]")) {
                            UserDetails.setUserDetails(
                                result.replaceAll("[USER]", ""));
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
                        "Sign In",
                        style: TextStyle(
                          fontFamily: 'selawk',
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          side: BorderSide(color: Hexcolor("#707070"))),
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 29),
                      color: Hexcolor("#E6D3D3").withOpacity(0.54),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Register()));
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 38, 0, 0),
                  child: Center(
                    child: InkWell(
                      child: Text(
                        "Continue without login",
                        style: TextStyle(
                            fontFamily: "selawk",
                            fontSize: 22,
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        setState(() {
                          status = "loading";
                        });
                        bool result = await auth.anonymousSignIn();
                        if (result) {
                          UserDetails.setUserDetails("anon");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Center(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontFamily: "selawk",
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
