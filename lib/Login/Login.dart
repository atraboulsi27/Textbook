import 'package:books_app/main.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              height: MediaQuery.of(context).size.height / 5,
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
                        height: 52.0,
                        width: 301,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
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
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
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
                          height: 52.0,
                          width: 301,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
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
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 38, 0, 0),
              child: Center(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Hexcolor("#707070"))),
                  padding: EdgeInsets.symmetric(vertical: 9, horizontal: 29),
                  color: Hexcolor("#E6D3D3").withOpacity(0.54),
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home())),
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
                child: Text(
                  "Continue without login",
                  style: TextStyle(
                      fontFamily: "selawk",
                      fontSize: 22,
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
    );
  }
}
