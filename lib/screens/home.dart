import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String expression = "";
  String answer = "923484";

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

  void onButtonTap(String val) {
    if (val == "AC") {
      expression = "";
      answer = "";
    } else if (val == "DEL") {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    } else if (val == "ANS") {
      expression += "A";
    } else if (val == "=") {
      answer = "Answer";
    } else {
      if (expression.length > 44) return;
      expression += val;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                  left: 26,
                  right: 26,
                  top: 30,
                  bottom: 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DisplayText(
                      isLeft: true,
                      maxLines: 4,
                      displayText: expression,
                    ),
                    DisplayText(
                      isLeft: false,
                      maxLines: 1,
                      displayText: answer,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Buttons(buttons: buttons, onButtonTap: onButtonTap),
        ],
      ),
    );
  }
}

class DisplayText extends StatelessWidget {
  final String displayText;
  final int maxLines;
  final bool isLeft;
  const DisplayText({
    super.key,
    required this.displayText,
    this.maxLines = 1,
    this.isLeft = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Text(
        displayText,
        maxLines: maxLines,
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.lato().fontFamily,
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final List<String> buttons;
  final Function(String) onButtonTap;
  const Buttons({super.key, required this.buttons, required this.onButtonTap});

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
              final String label = buttons[index];
              Color btnColor = const Color(0xFF333333);
              if (label == "AC" || label == "DEL" || label == "%") {
                btnColor = const Color(0xFF7E7E7E);
              } else if (["/", "x", "-", "+", "="].contains(label)) {
                btnColor = const Color(0xFFFF9F0A);
              }

              return MyButton(
                onButtonTap: () => onButtonTap(label),
                buttonColor: btnColor,
                textColor: Colors.white,
                buttonText: label,
              );
            },
          ),
        ),
      ),
    );
  }
}
