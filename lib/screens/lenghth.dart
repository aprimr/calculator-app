import 'package:calculator/widgets/app_navigation_bar.dart';
import 'package:flutter/material.dart';

class Length extends StatelessWidget {
  const Length({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(flex: 3, child: Container(color: Colors.blue)),
          AppNavigationBar(index: 1),
          Expanded(flex: 5, child: Container(color: Colors.yellow)),
        ],
      ),
    );
  }
}
