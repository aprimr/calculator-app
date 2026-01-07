import 'package:calculator/widgets/bmi_gauge.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum InputTarget { height, width, age }

class Bmi extends StatefulWidget {
  const Bmi({super.key});

  @override
  State<Bmi> createState() => _BmiState();
}

class _BmiState extends State<Bmi> {
  final List<String> numberButtons = [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    ".",
    "0",
    "=",
  ];

  String height = "0";
  String weight = "0";
  String age = "0";
  String bmiRes = "0";
  InputTarget selectedInput = InputTarget.height;

  void setInputTarget(InputTarget val) {
    selectedInput = val;
    setState(() {});
  }

  void calculateBMI(String height, String weight) {
    final double hCm = double.tryParse(height) ?? 0;
    final double wKg = double.tryParse(weight) ?? 0;

    if (hCm <= 0 || wKg <= 0) bmiRes = '0';

    final double hMeter = hCm / 100;
    final String res = (wKg / (hMeter * hMeter)).toStringAsFixed(1);
    bmiRes = res == "NaN" ? "0" : res;
  }

  void onButtonTap(String val) {
    if (val == "AC") {
      height = "0";
      weight = "0";
      age = "0";
      bmiRes = "0";
    } else if (val == "=") {
      calculateBMI(height, weight);
    } else if (selectedInput == InputTarget.height) {
      if (val == "DEL") {
        if (height.length <= 1) {
          height = "0";
        } else {
          height = height.substring(0, height.length - 1);
        }
        setState(() {});
        return;
      }
      if (height.length >= 5) return;
      if (val == "." && height.contains(".")) return;
      if (height == "0") {
        height = val == "." ? "0." : val;
      } else {
        height = height + val;
      }
    } else if (selectedInput == InputTarget.width) {
      if (val == "DEL") {
        if (weight.length <= 1) {
          weight = "0";
        } else {
          weight = weight.substring(0, weight.length - 1);
        }
        setState(() {});
        return;
      }
      if (weight.length >= 5) return;
      if (val == "." && weight.contains(".")) return;
      if (weight == "0") {
        weight = val == "." ? "0." : val;
      } else {
        weight = weight + val;
      }
    } else if (selectedInput == InputTarget.age) {
      if (val == "DEL") {
        if (age.length <= 1) {
          age = "0";
        } else {
          age = age.substring(0, age.length - 1);
        }
        setState(() {});
        return;
      }
      if (age.length >= 2) return;
      if (val == ".") return;
      if (age == "0") {
        age = val;
      } else {
        age = age + val;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('BMI Caclulator')),
      body: Column(
        children: [
          Display(
            height: height,
            weight: weight,
            age: age,
            selectedInput: selectedInput,
            setInputTarget: setInputTarget,
            bmiRes: bmiRes,
          ),
          Buttons(buttons: numberButtons, onButtonTap: onButtonTap),
        ],
      ),
    );
  }
}

class Display extends StatelessWidget {
  final String height;
  final String weight;
  final String age;
  final void Function(InputTarget) setInputTarget;
  final InputTarget selectedInput;
  final String bmiRes;
  const Display({
    super.key,
    required this.height,
    required this.weight,
    required this.age,
    required this.selectedInput,
    required this.setInputTarget,
    required this.bmiRes,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 26, right: 26, top: 15, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // first row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => setInputTarget(InputTarget.height),
                    child: Container(
                      width: 150,
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Height (cm)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: selectedInput == InputTarget.height
                                  ? Color(0xFFFF9F0A)
                                  : const Color(0xFFB4B4B4),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            height,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: selectedInput == InputTarget.height
                                  ? Color(0xFFFF9F0A)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => setInputTarget(InputTarget.width),
                    child: Container(
                      width: 150,
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Weight (kg)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: selectedInput == InputTarget.width
                                  ? Color(0xFFFF9F0A)
                                  : const Color(0xFFB4B4B4),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            weight,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: selectedInput == InputTarget.width
                                  ? Color(0xFFFF9F0A)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Spacer
              SizedBox(height: 30),

              // Second row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => setInputTarget(InputTarget.age),
                    child: Container(
                      width: 150,
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Age",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: selectedInput == InputTarget.age
                                  ? Color(0xFFFF9F0A)
                                  : const Color(0xFFB4B4B4),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            age,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: selectedInput == InputTarget.age
                                  ? Color(0xFFFF9F0A)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              BMIGauge(bmi: double.parse(bmiRes), age: int.parse(age)),
            ],
          ),
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
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            // Left
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Number Grid
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: buttons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                      itemBuilder: (context, index) {
                        final label = buttons[index];
                        Color btnColor = const Color(0xFF333333);
                        if (label == "=") {
                          btnColor = Color(0xFFFF9F0A);
                        } else if (label == ".") {
                          btnColor = Color(0xFF7E7E7E);
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

                  SizedBox(height: 20),
                ],
              ),
            ),

            // Right
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(bottom: 10, top: 0),
                child: Column(
                  children: [
                    Expanded(
                      child: MyButton(
                        buttonText: "DEL",
                        buttonColor: Color(0xFF7E7E7E),
                        textColor: Colors.white,
                        onButtonTap: () => onButtonTap("DEL"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: MyButton(
                        buttonText: "AC",
                        buttonColor: Colors.red,
                        textColor: Colors.white,
                        onButtonTap: () => onButtonTap("AC"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
