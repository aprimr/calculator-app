import 'package:calculator/widgets/app_navigation_bar.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum InputTarget { from, to }

class Length extends StatefulWidget {
  const Length({super.key});

  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
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
    "⇆",
  ];

  String selectedFromUnit = "m";
  String selectedToUnit = "m";
  String fromVal = "12321";
  String toVal = "1";
  InputTarget currentOperating = InputTarget.from;
  final List<String> lengthUnits = ["m", "cm", "mm", "km", "in", "ft"];
  final Map<String, double> lengthToMeter = {
    "m": 1.0,
    "cm": 0.01,
    "mm": 0.001,
    "km": 1000.0,
    "in": 0.0254,
    "ft": 0.3048,
  };
  final Map<String, String> unitToName = {
    "m": "Meter",
    "cm": "Centimeter",
    "mm": "Milimeter",
    "km": "Kilometer",
    "in": "Inch",
    "ft": "Feet",
  };

  void onFromUnitChanged(String unit) {
    setState(() {
      selectedFromUnit = unit;
    });
  }

  void onToUnitChanged(String unit) {
    setState(() {
      selectedToUnit = unit;
    });
  }

  dynamic onCurrentOperatingChanged(InputTarget inputTarget) {
    setState(() {
      currentOperating = inputTarget;
    });
  }

  void onButtonTap(String val) {
    print(val);
    if (currentOperating == InputTarget.from) {
      if (val == "DEL") {
        if (fromVal.length == 1) {
          fromVal = "0";
        } else {
          fromVal = fromVal.substring(0, fromVal.length - 1);
        }
      } else if (val == "AC") {
        fromVal = "0";
      } else if (val == "=") {
      } else if (val == "⇆") {
      } else {
        if (fromVal == "0") {
          fromVal = val;
        } else if (fromVal.length < 8) {
          fromVal = fromVal + val;
        }
      }
    }
    if (currentOperating == InputTarget.to) {
      if (val == "DEL") {
        if (toVal.length == 1) {
          toVal = "0";
        } else {
          toVal = toVal.substring(0, toVal.length - 1);
        }
      } else if (val == "AC") {
        toVal = "0";
      } else if (val == "=") {
      } else if (val == "⇆") {
      } else {
        if (toVal == "0") {
          toVal = val;
        } else if (toVal.length < 8) {
          toVal = toVal + val;
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Display(
            selectedFromUnit: selectedFromUnit,
            selectedToUnit: selectedToUnit,
            fromVal: fromVal,
            toVal: toVal,
            currentOperating: currentOperating,
            lengthUnits: lengthUnits,
            unitToName: unitToName,
            onFromUnitChanged: onFromUnitChanged,
            onToUnitChanged: onToUnitChanged,
            onCurrentOperatingChanged: onCurrentOperatingChanged,
          ),
          AppNavigationBar(index: 1),
          Buttons(buttons: numberButtons, onButtonTap: onButtonTap),
        ],
      ),
    );
  }
}

class Display extends StatelessWidget {
  final List<String> lengthUnits;
  final Map<String, String> unitToName;
  final InputTarget currentOperating;
  final String selectedFromUnit;
  final String selectedToUnit;
  final String fromVal;
  final String toVal;
  final Function(String) onFromUnitChanged;
  final Function(String) onToUnitChanged;
  final Function(InputTarget) onCurrentOperatingChanged;

  const Display({
    super.key,
    required this.lengthUnits,
    required this.selectedFromUnit,
    required this.selectedToUnit,
    required this.fromVal,
    required this.toVal,
    required this.onFromUnitChanged,
    required this.onToUnitChanged,
    required this.unitToName,
    required this.currentOperating,
    required this.onCurrentOperatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SafeArea(
        child: Container(
          // color: Colors.blue,
          padding: EdgeInsets.only(left: 36, right: 36, top: 50, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // From row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Unit Selector
                  DropdownButton<String>(
                    value: selectedFromUnit,
                    dropdownColor: Color(0xFF313131),
                    underline: Text(''),
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 24,
                    ),
                    items: lengthUnits
                        .map(
                          (unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(
                              unit,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) onFromUnitChanged(val);
                    },
                  ),
                  // Value
                  GestureDetector(
                    onTap: () {
                      onCurrentOperatingChanged(InputTarget.from);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          fromVal.toString(),
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 28,
                            color: currentOperating == InputTarget.from
                                ? Color(0xFFFF9F0A)
                                : Colors.white,
                          ),
                        ),
                        Text(
                          unitToName[selectedFromUnit]!,
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 12,
                            color: currentOperating == InputTarget.from
                                ? Color(0xFFFF9F0A)
                                : Color(0xFF909090),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // To row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Unit Selector
                  DropdownButton<String>(
                    value: selectedToUnit,
                    dropdownColor: Color(0xFF313131),
                    underline: Text(''),
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 24,
                    ),
                    items: lengthUnits
                        .map(
                          (unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(
                              unit,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) onToUnitChanged(val);
                    },
                  ),
                  // Value
                  GestureDetector(
                    onTap: () {
                      onCurrentOperatingChanged(InputTarget.to);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          toVal.toString(),
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 28,
                            color: currentOperating == InputTarget.to
                                ? Color(0xFFFF9F0A)
                                : Colors.white,
                          ),
                        ),
                        Text(
                          unitToName[selectedToUnit]!,
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 12,
                            color: currentOperating == InputTarget.to
                                ? Color(0xFFFF9F0A)
                                : Color(0xFF909090),
                            fontWeight: FontWeight.bold,
                          ),
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
      flex: 7,
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
                        if (label == "⇆") {
                          btnColor = const Color(0xFF7E7E7E);
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

                  // Calculate Btn
                  SizedBox(
                    height: 85,
                    width: double.infinity,
                    child: MyButton(
                      buttonText: "=",
                      buttonColor: Color(0xFFFF9F0A),
                      textColor: Colors.white,
                      onButtonTap: () => onButtonTap("="),
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
                padding: EdgeInsets.symmetric(vertical: 20),
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
