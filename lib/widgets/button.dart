import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final Color textColor;
  final onButtonTap;

  const MyButton({
    super.key,
    required this.buttonColor,
    required this.buttonText,
    required this.textColor,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: buttonColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
