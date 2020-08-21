import 'package:books_app/Login/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  Authentication auth = Authentication();
  TextEditingController emailController, passController, cpassController;
  GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passController = TextEditingController();
    cpassController = TextEditingController();
  }

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
        child: Form(
          key: formKey,
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
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                              controller: passController,
                              obscureText: true,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Center(
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
                            height: 52.0,
                            width: 301,
                            child: TextFormField(
                              controller: cpassController,
                              obscureText: true,
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
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field can\'t be empty.';
                                } else if (value.length < 6)
                                  return "Password must be 6 or more characters";
                                else if (passController.text !=
                                    cpassController.text)
                                  return "Passwords do not match";
                                else
                                  return null;
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 33, 0, 0),
                child: Center(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Hexcolor("#707070"))),
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 29),
                    color: Hexcolor("#E6D3D3").withOpacity(0.54),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        bool result = await auth.register(
                            emailController.text, passController.text);
                        if (result) {
                          Navigator.pop(context);
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
