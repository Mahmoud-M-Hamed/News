import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CurvedNavBar extends StatefulWidget {
  const CurvedNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurvedNavBarState createState() => _CurvedNavBarState();
}

class _CurvedNavBarState extends State<CurvedNavBar> {
  int index = 0;

  final List<Widget> curvedNavigationBarItems = [
    const Icon(
      Icons.add,
      semanticLabel: 'home',
      size: 25,
      color: Colors.deepOrange,
    ),
    const Icon(
      Icons.home,
      semanticLabel: 'home',
      size: 25,
      color: Colors.deepOrange,
    ),
    const Icon(
      Icons.clear,
      semanticLabel: 'home',
      size: 25,
      color: Colors.deepOrange,
    ),
    const Icon(
      Icons.search,
      semanticLabel: 'home',
      size: 25,
      color: Colors.deepOrange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: CurvedNavigationBar(
        index: index,
        items: curvedNavigationBarItems,
        color: Colors.white,
        onTap: (index) {
          this.index = index;
        },
        backgroundColor: Colors.deepOrange,
        animationDuration: const Duration(milliseconds: 900),
        buttonBackgroundColor: Colors.white,
      ),
    );
  }
}
