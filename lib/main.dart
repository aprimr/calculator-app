import 'package:calculator/screens/currency.dart';
import 'package:calculator/screens/home.dart';
import 'package:calculator/screens/lenghth.dart';
import 'package:calculator/screens/more.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        "/length": (context) => Length(),
        "/currency": (context) => Currency(),
        "/more": (context) => More(),
      },
    );
  }
}
