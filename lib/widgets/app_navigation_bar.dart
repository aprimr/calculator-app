import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

// ignore: must_be_immutable
class AppNavigationBar extends StatefulWidget {
  late int index;
  AppNavigationBar({super.key, required this.index});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  List<String> navItems = ['/', "/length", "/currency", '/more'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navItem(0, HugeIcons.strokeRoundedCalculate),
          navItem(1, HugeIcons.strokeRoundedCoordinate01),
          navItem(2, HugeIcons.strokeRoundedExchange03),
          navItem(3, HugeIcons.strokeRoundedMore01),
        ],
      ),
    );
  }

  Widget navItem(int i, dynamic icon) {
    return IconButton(
      onPressed: () => {
        setState(() => widget.index = i),
        Navigator.pushNamed(context, navItems[i]),
      },
      icon: Center(
        child: HugeIcon(
          icon: icon,
          color: widget.index == i ? Colors.blue : Colors.grey,
          size: 26,
          strokeWidth: i == 3 ? 3.5 : 1.5,
        ),
      ),
    );
  }
}
