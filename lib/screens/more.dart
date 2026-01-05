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
      "Length": "/",
      "Currency": "/",
      "Area": "/",
      "BMI": "/",
      "Mass": "/",
      "Speed": "/",
      "Temperature": "/",
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
              crossAxisSpacing: 16,
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
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: HugeIcon(
                            icon: icons[index],
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          items[index],
                          style: TextStyle(
                            color: const Color(0xFF959595),
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
