import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

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
  bool isMale = true;
  InputTarget selectedInput = InputTarget.height;

  void setInputTarget(InputTarget val) {
    selectedInput = val;
    setState(() {});
  }

  void setGender(bool value) {
    isMale = value;
    setState(() {});
  }

  void onButtonTap(String val) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('BMI')),
      body: Column(
        children: [
          Display(
            isMale: isMale,
            setGender: setGender,
            selectedInput: selectedInput,
            setInputTarget: setInputTarget,
          ),
          Buttons(buttons: numberButtons, onButtonTap: onButtonTap),
        ],
      ),
    );
  }
}

class Display extends StatelessWidget {
  final bool isMale;
  final void Function(bool) setGender;
  final void Function(InputTarget) setInputTarget;
  final InputTarget selectedInput;
  const Display({
    super.key,
    required this.isMale,
    required this.setGender,
    required this.selectedInput,
    required this.setInputTarget,
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
                    child: SizedBox(
                      width: 150,
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
                            "123",
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
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Width (kg)",
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
                            "123",
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
                    child: SizedBox(
                      width: 150,
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
                            "123",
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
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: const Color(0xFFB4B4B4),
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setGender(!isMale);
                              },
                              icon: Column(
                                children: [
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedMaleSymbol,
                                    size: 24,
                                    strokeWidth: 2,
                                    color: isMale
                                        ? Colors.amber
                                        : Colors.blueAccent,
                                  ),
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedTick02,
                                    size: 10,
                                    strokeWidth: 2,
                                    color: isMale ? Colors.white : Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            IconButton(
                              onPressed: () {
                                setGender(!isMale);
                              },
                              icon: Column(
                                children: [
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedFemaleSymbol,
                                    size: 24,
                                    strokeWidth: 2,
                                    color: !isMale
                                        ? Colors.amber
                                        : Colors.purpleAccent,
                                  ),
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedTick02,
                                    size: 10,
                                    strokeWidth: 2,
                                    color: !isMale
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
