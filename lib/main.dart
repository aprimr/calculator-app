import 'package:calculator/screens/area.dart';
import 'package:calculator/screens/currency.dart';
import 'package:calculator/screens/home.dart';
import 'package:calculator/screens/lenghth.dart';
import 'package:calculator/screens/mass.dart';
import 'package:calculator/screens/more.dart';
import 'package:calculator/screens/speed.dart';
import 'package:calculator/screens/temperature.dart';
import 'package:calculator/utils/theme.dart';
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
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        "/length": (context) => Length(),
        "/currency": (context) => Currency(),
        "/more": (context) => More(),
        "/area": (context) => Area(),
        "/temperature": (context) => Temperature(),
        "/mass": (context) => Mass(),
        "/speed": (context) => Speed(),
      },
    );
  }
}
