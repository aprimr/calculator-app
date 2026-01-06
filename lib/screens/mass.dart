import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mass extends StatefulWidget {
  const Mass({super.key});

  @override
  State<Mass> createState() => _MassState();
}

class _MassState extends State<Mass> {
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

  String selectedFromUnit = "kg";
  String selectedToUnit = "kg";
  String fromVal = "0";
  String toVal = "0";

  final List<String> massUnits = ["kg", "g", "mg", "t", "lb", "oz", "st"];

  final Map<String, double> massToKilogram = {
    "kg": 1.0,
    "g": 0.001,
    "mg": 0.000001,
    "t": 1000.0,

    "lb": 0.45359237,
    "oz": 0.028349523125,
    "st": 6.35029318,
  };

  final Map<String, String> unitToName = {
    "kg": "Kilogram",
    "g": "Gram",
    "mg": "Milligram",
    "t": "Metric Ton",

    "lb": "Pound",
    "oz": "Ounce",
    "st": "Stone",
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

  double convert(String value, String fromUnit, String toUnit) {
    final double input = double.tryParse(value) ?? 0.0;

    final double fromFactor = massToKilogram[fromUnit]!;
    final double toFactor = massToKilogram[toUnit]!;

    return double.parse((input * fromFactor / toFactor).toStringAsFixed(3));
  }

  void reverseUnits(String fromUnit, String toUnit) {
    String temp;
    setState(() {
      temp = fromUnit;
      selectedFromUnit = toUnit;
      selectedToUnit = temp;
    });
    calculate(fromVal, selectedFromUnit, selectedToUnit);
  }

  void calculate(String value, String fromUnit, String toUnit) {
    double result = convert(value, fromUnit, toUnit);
    toVal = result.toString();
    setState(() {});
  }

  void onButtonTap(String val) {
    if (val == "DEL") {
      if (fromVal.length == 1) {
        fromVal = "0";
      } else {
        fromVal = fromVal.substring(0, fromVal.length - 1);
      }
    } else if (val == "AC") {
      fromVal = "0";
      toVal = "0";
    } else if (val == "=") {
      calculate(fromVal, selectedFromUnit, selectedToUnit);
    } else if (val == "⇆") {
      reverseUnits(selectedFromUnit, selectedToUnit);
    } else {
      if (fromVal == "0") {
        fromVal = val;
      } else if (fromVal.length < 8) {
        fromVal = fromVal + val;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Mass')),
      body: Column(
        children: [
          Display(
            selectedFromUnit: selectedFromUnit,
            selectedToUnit: selectedToUnit,
            fromVal: fromVal,
            toVal: toVal,
            massUnits: massUnits,
            unitToName: unitToName,
            onFromUnitChanged: onFromUnitChanged,
            onToUnitChanged: onToUnitChanged,
          ),
          Buttons(buttons: numberButtons, onButtonTap: onButtonTap),
        ],
      ),
    );
  }
}

class Display extends StatelessWidget {
  final List<String> massUnits;
  final Map<String, String> unitToName;
  final String selectedFromUnit;
  final String selectedToUnit;
  final String fromVal;
  final String toVal;
  final Function(String) onFromUnitChanged;
  final Function(String) onToUnitChanged;

  const Display({
    super.key,
    required this.massUnits,
    required this.selectedFromUnit,
    required this.selectedToUnit,
    required this.fromVal,
    required this.toVal,
    required this.onFromUnitChanged,
    required this.onToUnitChanged,
    required this.unitToName,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SafeArea(
        child: Container(
          // color: Colors.blue,
          padding: EdgeInsets.only(left: 36, right: 36, top: 40, bottom: 70),
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
                    items: massUnits
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        fromVal.toString(),
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 28,
                          color: Color(0xFFFF9F0A),
                        ),
                      ),
                      Text(
                        unitToName[selectedFromUnit]!,
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 12,
                          color: Color(0xFFFF9F0A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                    items: massUnits
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        toVal.toString(),
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        unitToName[selectedToUnit]!,
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 12,
                          color: Color(0xFF909090),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                padding: EdgeInsets.only(bottom: 20, top: 5),
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
