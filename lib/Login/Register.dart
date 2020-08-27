import 'package:books_app/Login/Authentication.dart';
import 'package:books_app/main.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    cpassController = TextEditingController();
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
                height: MediaQuery.of(context).size.height / 7,
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
                        String result = await auth.register(
                            emailController.text.trim(),
                            nameController.text.trim(),
                            passController.text.trim());
                        if (result == "[SUCCESS]") {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        } else {
                          print(result);
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
