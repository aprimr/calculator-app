import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String expression = "";
  String answer = "";
  String ans = "";

  final List<String> buttons = [
    "AC",
    "DEL",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
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

  void onButtonTap(String val) async {
    if (val == "AC") {
      expression = "";
      answer = "";
    } else if (val == "DEL") {
      answer = "";
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    } else if (val == "ANS") {
      expression += ans;
    } else if (val == "=") {
      calclate();
    } else {
      answer = "";
      if (expression.length > 44) return;
      expression += val;
    }
    setState(() {});
  }

  void calclate() {
    String temp = expression.replaceAll("×", "*").replaceAll("÷", "/");
    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(temp);

    var context = ContextModel();

    var evaluator = RealEvaluator(context);
    num eval = evaluator.evaluate(exp);

    if (eval % 1 == 0) {
      answer = eval.toInt().toString();
    } else {
      answer = eval.toString();
    }
    ans = answer;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
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
                      maxLines: 3,
                      displayText: expression,
                    ),
                    DisplayText(
                      isLeft: false,
                      maxLines: 2,
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
          overflow: TextOverflow.fade,
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
      flex: 5,
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 4),
        child: Center(
          child: GridView.builder(
            itemCount: buttons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final String label = buttons[index];
              Color btnColor = const Color(0xFF333333);
              if (label == "AC" || label == "DEL" || label == "%") {
                btnColor = const Color(0xFF7E7E7E);
              } else if (["÷", "×", "-", "+", "="].contains(label)) {
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
