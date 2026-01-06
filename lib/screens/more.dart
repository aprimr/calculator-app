import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    final List icons = [
      HugeIcons.strokeRoundedCalculate,
      HugeIcons.strokeRoundedRuler,
      HugeIcons.strokeRoundedExchange03,
      HugeIcons.strokeRoundedSquareArrowExpand02,
      HugeIcons.strokeRoundedWeightScale,
      HugeIcons.strokeRoundedWeightScale01,
      HugeIcons.strokeRoundedDashboardSpeed01,
      HugeIcons.strokeRoundedTemperature,
      HugeIcons.strokeRoundedClock01,
      HugeIcons.strokeRoundedDashboardSpeed01,
    ];
    final List<String> items = [
      "Calculator",
      "Length",
      "Currency",
      "Area",
      "BMI",
      "Mass",
      "Speed",
      "Temperature",
      "Time",
    ];
    final Map<String, String> itemRoutes = {
      "Calculator": "/",
      "Length": "/length",
      "Currency": "/currency",
      "Area": "/area",
      "BMI": "/",
      "Mass": "/mass",
      "Speed": "/",
      "Temperature": "/temperature",
      "Time": "/",
    };
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("More")),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 38,
              crossAxisSpacing: 20,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 9,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, itemRoutes[item]!);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111111),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: HugeIcon(
                            icon: icons[index],
                            size: 34,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          items[index],
                          style: TextStyle(
                            color: const Color(0xFFA5A5A5),
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
