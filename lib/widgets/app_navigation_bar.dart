import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navItem(0, Icons.calculate),
          navItem(1, Icons.straighten),
          navItem(2, Icons.currency_exchange),
          navItem(3, Icons.apps_rounded),
        ],
      ),
    );
  }

  Widget navItem(int i, IconData icon) {
    return IconButton(
      onPressed: () => setState(() => index = i),
      icon: Icon(icon, color: index == i ? Colors.blue : Colors.grey, size: 28),
    );
  }
}
