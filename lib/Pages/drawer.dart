import 'package:books_app/Login/Login.dart';
import 'package:flutter/material.dart';

Widget BookDrawer(BuildContext context) {
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 30),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints.expand(height: 120, width: 120),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF804A4A),
                  width: 3
                )
              ),
              child: Center(
                child: Text("Logo", style: TextStyle(
                  color: Color(0xFFA07070),
                  fontSize: 30
                ),),
              ),
            ),
          ),
        ),
        Divider(
          thickness: 2,
          height: 30,
          color: Color(0xFF804A4A),
          indent: 30,
          endIndent: 30,
        ),
        DrawerButton(Icons.settings, "Settings", (){}),
        DrawerButton(Icons.contacts, "Contact Us", (){}),
        DrawerButton(Icons.info, "About", (){}),
        DrawerButton(Icons.cancel, "Sign Out", (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Login()));}),
      ],
    ),
  );
}

Widget DrawerButton(IconData icon, String label, Function function){
  return
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Container(
        width: double.infinity,
        child: FlatButton(
          onPressed: function,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Color(0xFF804A4A),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(label, style: TextStyle(
                    color: Color(0xFFA07070),
                    fontSize: 17
                ),),
              ],
            ),
          ),
        ),
      ),
    );
}
