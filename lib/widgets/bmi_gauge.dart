import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class BMIGauge extends StatelessWidget {
  final double bmi;

  const BMIGauge({super.key, required this.bmi});

  @override
  Widget build(BuildContext context) {
    // BMI category boundaries
    final double underweightEnd = 18.5;
    final double normalEnd = 24.9;
    final double overweightEnd = 29.9;
    final double obeseEnd = 40.0;

    final double maxGaugeValue = 42.0;

    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 80),
        Text(
          "BMI: ${bmi.toStringAsFixed(1)}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        SizedBox(height: 12),

        Stack(
          children: [
            Container(
              height: 45,
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
              top: 7,
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedVerticalScrollPoint,
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
              child: const GaugeLabel(text: "Underweight"),
            ),
            SizedBox(
              width:
                  ((normalEnd - underweightEnd) / maxGaugeValue) * screenWidth,
              child: const GaugeLabel(text: "Normal"),
            ),
            SizedBox(
              width:
                  ((overweightEnd - normalEnd) / maxGaugeValue) * screenWidth,
              child: const GaugeLabel(text: "Overweight"),
            ),
            Expanded(child: const GaugeLabel(text: "Obese")),
          ],
        ),
      ],
    );
  }
}

class GaugeLabel extends StatelessWidget {
  final String text;
  const GaugeLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}
