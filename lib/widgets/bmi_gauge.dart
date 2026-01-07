import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIGauge extends StatelessWidget {
  final double bmi;
  final int age;

  const BMIGauge({super.key, required this.bmi, required this.age});

  String _getBMICategory() {
    if (age < 20) {
      return _getChildBMICategory();
    } else if (age >= 65) {
      return _getElderlyBMICategory();
    } else {
      return _getAdultBMICategory();
    }
  }

  String _getAdultBMICategory() {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  String _getElderlyBMICategory() {
    if (bmi < 23) return "Underweight";
    if (bmi < 30) return "Normal";
    if (bmi < 35) return "Overweight";
    return "Obese";
  }

  String _getChildBMICategory() {
    if (age < 2) return "Min age must be 2";

    double adjustedUnderweight = 14 + (age * 0.25);
    double adjustedNormal = 16 + (age * 0.25);
    double adjustedOverweight = 20 + (age * 0.25);

    if (bmi < adjustedUnderweight) return "Underweight";
    if (bmi < adjustedNormal) return "Normal";
    if (bmi < adjustedOverweight) return "Overweight";
    return "Obese";
  }

  Color _getCategoryColor() {
    final category = _getBMICategory();
    switch (category) {
      case "Underweight":
        return Colors.blue;
      case "Normal":
        return Colors.green;
      case "Overweight":
        return Colors.orange;
      case "Obese":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String category = _getBMICategory();
    final Color categoryColor = _getCategoryColor();

    final double underweightEnd = age >= 65 ? 23.0 : 18.5;
    final double normalEnd = age >= 65 ? 30.0 : 24.9;
    final double overweightEnd = age >= 65 ? 35.0 : 29.9;
    final double maxGaugeValue = age >= 65 ? 45.0 : 42.0;

    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Text(
          "BMI: ${bmi.toStringAsFixed(1)}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),

        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: categoryColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              category,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Gauge
        Stack(
          children: [
            Container(
              height: 25,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.green,
                    Colors.orange,
                    Colors.red,
                  ],
                  stops: [
                    underweightEnd / maxGaugeValue,
                    normalEnd / maxGaugeValue,
                    overweightEnd / maxGaugeValue,
                    1.0,
                  ],
                ),
              ),
            ),

            // Pointer
            Positioned(
              left:
                  (bmi / maxGaugeValue) *
                  screenWidth.clamp(0.0, screenWidth - 30),
              top: -3,
              child: Icon(
                Icons.arrow_drop_down_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),

        SizedBox(height: 8),

        Row(
          children: [
            SizedBox(
              width: (underweightEnd / maxGaugeValue) * screenWidth,
              child: Text(
                "Underweight",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width:
                  ((normalEnd - underweightEnd) / maxGaugeValue) * screenWidth,
              child: Text(
                "Normal",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width:
                  ((overweightEnd - normalEnd) / maxGaugeValue) * screenWidth,
              child: Text(
                "Overweight",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                "Obese",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
