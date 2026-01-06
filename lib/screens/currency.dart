import 'package:calculator/widgets/app_navigation_bar.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Currency extends StatefulWidget {
  const Currency({super.key});

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
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

  String selectedFromUnit = "USD";
  String selectedToUnit = "NPR";
  String fromVal = "0";
  String toVal = "0";
  final List<String> currencies = [
    "USD",
    "EUR",
    "GBP",
    "NPR",
    "INR",
    "CNY",
    "JPY",
    "KRW",
    "AUD",
    "CAD",
    "CHF",
    "NZD",
    "SGD",
    "MYR",
    "THB",
    "IDR",
    "PHP",
    "VND",
    "AED",
    "SAR",
    "QAR",
    "KWD",
    "OMR",
    "BHD",
    "PKR",
    "BDT",
    "LKR",
    "RUB",
    "UAH",
    "PLN",
    "CZK",
    "HUF",
    "SEK",
    "NOK",
    "DKK",
    "BRL",
    "ARS",
    "CLP",
    "COP",
    "MXN",
    "ZAR",
    "NGN",
    "EGP",
    "KES",
  ];
  final Map<String, double> currencyToUSD = {
    "USD": 1.0,
    "EUR": 0.92,
    "GBP": 0.78,
    "NPR": 132.8,
    "INR": 83.0,
    "CNY": 7.18,
    "JPY": 146.0,
    "KRW": 1320.0,

    "AUD": 1.52,
    "CAD": 1.36,
    "CHF": 0.88,
    "NZD": 1.64,

    "SGD": 1.34,
    "MYR": 4.65,
    "THB": 35.7,
    "IDR": 15600.0,
    "PHP": 56.0,
    "VND": 24500.0,

    "AED": 3.67,
    "SAR": 3.75,
    "QAR": 3.64,
    "KWD": 0.31,
    "OMR": 0.38,
    "BHD": 0.38,

    "PKR": 278.0,
    "BDT": 110.0,
    "LKR": 310.0,

    "RUB": 92.0,
    "UAH": 38.0,
    "PLN": 4.0,
    "CZK": 23.0,
    "HUF": 360.0,
    "SEK": 10.4,
    "NOK": 10.6,
    "DKK": 6.9,

    "BRL": 4.95,
    "ARS": 350.0,
    "CLP": 930.0,
    "COP": 3950.0,
    "MXN": 17.0,

    "ZAR": 18.6,
    "NGN": 900.0,
    "EGP": 31.0,
    "KES": 145.0,
  };
  final Map<String, String> currencyToName = {
    "USD": "US Dollar",
    "EUR": "Euro",
    "GBP": "British Pound",
    "NPR": "Nepalese Rupee",
    "INR": "Indian Rupee",
    "CNY": "Chinese Yuan",
    "JPY": "Japanese Yen",
    "KRW": "South Korean Won",

    "AUD": "Australian Dollar",
    "CAD": "Canadian Dollar",
    "CHF": "Swiss Franc",
    "NZD": "New Zealand Dollar",

    "SGD": "Singapore Dollar",
    "MYR": "Malaysian Ringgit",
    "THB": "Thai Baht",
    "IDR": "Indonesian Rupiah",
    "PHP": "Philippine Peso",
    "VND": "Vietnamese Dong",

    "AED": "UAE Dirham",
    "SAR": "Saudi Riyal",
    "QAR": "Qatari Riyal",
    "KWD": "Kuwaiti Dinar",
    "OMR": "Omani Rial",
    "BHD": "Bahraini Dinar",

    "PKR": "Pakistani Rupee",
    "BDT": "Bangladeshi Taka",
    "LKR": "Sri Lankan Rupee",

    "RUB": "Russian Ruble",
    "UAH": "Ukrainian Hryvnia",
    "PLN": "Polish Zloty",
    "CZK": "Czech Koruna",
    "HUF": "Hungarian Forint",
    "SEK": "Swedish Krona",
    "NOK": "Norwegian Krone",
    "DKK": "Danish Krone",

    "BRL": "Brazilian Real",
    "ARS": "Argentine Peso",
    "CLP": "Chilean Peso",
    "COP": "Colombian Peso",
    "MXN": "Mexican Peso",

    "ZAR": "South African Rand",
    "NGN": "Nigerian Naira",
    "EGP": "Egyptian Pound",
    "KES": "Kenyan Shilling",
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

  double convertLength(String value, String fromUnit, String toUnit) {
    final double input = double.tryParse(value) ?? 0.0;

    final double fromFactor = currencyToUSD[fromUnit]!;
    final double toFactor = currencyToUSD[toUnit]!;

    return double.parse((input * toFactor / fromFactor).toStringAsFixed(3));
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
    double result = convertLength(value, fromUnit, toUnit);
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
      body: Column(
        children: [
          Display(
            selectedFromUnit: selectedFromUnit,
            selectedToUnit: selectedToUnit,
            fromVal: fromVal,
            toVal: toVal,
            currencies: currencies,
            currencyToName: currencyToName,
            onFromUnitChanged: onFromUnitChanged,
            onToUnitChanged: onToUnitChanged,
          ),
          AppNavigationBar(index: 2),
          Buttons(buttons: numberButtons, onButtonTap: onButtonTap),
        ],
      ),
    );
  }
}

class Display extends StatelessWidget {
  final List<String> currencies;
  final Map<String, String> currencyToName;
  final String selectedFromUnit;
  final String selectedToUnit;
  final String fromVal;
  final String toVal;
  final Function(String) onFromUnitChanged;
  final Function(String) onToUnitChanged;

  const Display({
    super.key,
    required this.currencies,
    required this.selectedFromUnit,
    required this.selectedToUnit,
    required this.fromVal,
    required this.toVal,
    required this.onFromUnitChanged,
    required this.onToUnitChanged,
    required this.currencyToName,
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
                    items: currencies
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
                        currencyToName[selectedFromUnit]!,
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
                    items: currencies
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
                        currencyToName[selectedToUnit]!,
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
