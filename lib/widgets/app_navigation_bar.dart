import 'package:flutter/material.dart';

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
      onPressed: () => {
        setState(() => widget.index = i),
        Navigator.pushNamed(context, navItems[i]),
      },
      icon: Icon(
        icon,
        color: widget.index == i ? Colors.blue : Colors.grey,
        size: 28,
      ),
    );
  }
}
