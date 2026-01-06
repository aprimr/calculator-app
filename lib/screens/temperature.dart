import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
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
    "-",
  ];

  String selectedFromUnit = "°C";
  String selectedToUnit = "°C";
  String fromVal = "0";
  String toVal = "0";

  final List<String> temperatureUnits = ["°C", "°F", "K"];

  final Map<String, String> unitToName = {
    "°C": "Celsius",
    "°F": "Fahrenheit",
    "K": "Kelvin",
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

    if (fromUnit == toUnit) return input;

    double celsius;
    switch (fromUnit) {
      case "°C":
        celsius = input;
        break;
      case "°F":
        celsius = (input - 32) * 5 / 9;
        break;
      case "K":
        celsius = input - 273.15;
        break;
      default:
        return 0;
    }

    switch (toUnit) {
      case "°C":
        return celsius;
      case "°F":
        return (celsius * 9 / 5) + 32;
      case "K":
        return celsius + 273.15;
      default:
        return 0;
    }
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
    toVal = result.toStringAsFixed(3);
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
    } else if (val == "-") {
      if (fromVal == "0") {
        fromVal = "-";
      }
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
      appBar: AppBar(title: Text('Temperature')),
      body: Column(
        children: [
          Display(
            selectedFromUnit: selectedFromUnit,
            selectedToUnit: selectedToUnit,
            fromVal: fromVal,
            toVal: toVal,
            temperatureUnits: temperatureUnits,
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
  final List<String> temperatureUnits;
  final Map<String, String> unitToName;
  final String selectedFromUnit;
  final String selectedToUnit;
  final String fromVal;
  final String toVal;
  final Function(String) onFromUnitChanged;
  final Function(String) onToUnitChanged;

  const Display({
    super.key,
    required this.temperatureUnits,
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
                    items: temperatureUnits
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
                    items: temperatureUnits
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
                      flex: 2,
                      child: MyButton(
                        buttonText: "DEL",
                        buttonColor: Color(0xFF7E7E7E),
                        textColor: Colors.white,
                        onButtonTap: () => onButtonTap("DEL"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 2,
                      child: MyButton(
                        buttonText: "AC",
                        buttonColor: Colors.red,
                        textColor: Colors.white,
                        onButtonTap: () => onButtonTap("AC"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 1,
                      child: MyButton(
                        buttonText: "⇆",
                        buttonColor: Color(0xFF7E7E7E),
                        textColor: Colors.white,
                        onButtonTap: () => onButtonTap("⇆"),
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
