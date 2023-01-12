import 'package:flutter/material.dart';
import 'package:midpractice/homepage.dart';

void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[100],
    ),
    home: const HomePage(),
  ));
}