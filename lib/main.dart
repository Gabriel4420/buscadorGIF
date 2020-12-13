//import 'package:buscador_gif/user_interface/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:buscador_gif/user_interface/home_page.dart';

void main() {
  runApp(MaterialApp(
    home:HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
        brightness: Brightness.light,
    fixTextFieldOutlineLabel: true,
    inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueAccent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.purple[600],
            )),
            focusColor: Colors.redAccent[400],
            hintStyle: TextStyle(color: Colors.white),
            helperStyle: TextStyle(color: Colors.redAccent[400]),
            ),
        backgroundColor: Colors.black),
        debugShowCheckedModeBanner: false,
    ),
  );
}
