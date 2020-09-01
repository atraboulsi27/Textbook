import 'package:books_app/Login/Authentication.dart';
import 'package:books_app/main.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Register.dart';
import 'package:auto_size_text/auto_size_text.dart';

String error = "";

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController, passController;
  GlobalKey<FormState> formKey;

  Authentication auth = Authentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();

    emailController = new TextEditingController();
    passController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
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
              error == ""
                  ? Container()
                  : Center(
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: AutoSizeText(
                            error,
                            minFontSize: 15,
                            style: TextStyle(color: Colors.redAccent.shade100),
                          )),
                    ),
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
                      if (formKey.currentState.validate()) {
                        String result = await auth.signIn(
                            emailController.text.trim(),
                            passController.text.trim());
                        if (result == "[SUCCESS]") {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        } else {
                          setState(() {
                            error = result;
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
                      bool result = await auth.anonymousSignIn();
                      if (result)
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Home()));
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
    );
  }
}
