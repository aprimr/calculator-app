import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> buttons = [
    "AC",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    '6',
    "-",
    "1",
    "2",
    "3",
    "+",
    ".",
    "0",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Buttons(buttons: buttons),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key, required this.buttons});

  final List<String> buttons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 30),
        child: Center(
          child: GridView.builder(
            itemCount: buttons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (BuildContext context, int index) {
              return MyButton(
                buttonColor:
                    buttons[index] == "AC" ||
                        buttons[index] == "DEL" ||
                        buttons[index] == "%"
                    ? Color(0xFF7E7E7E)
                    : buttons[index] == "/" ||
                          buttons[index] == "x" ||
                          buttons[index] == "-" ||
                          buttons[index] == "+" ||
                          buttons[index] == "="
                    ? Color(0xFFFF9F0A)
                    : Color(0xFF333333),
                textColor: Colors.white,
                buttonText: buttons[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
