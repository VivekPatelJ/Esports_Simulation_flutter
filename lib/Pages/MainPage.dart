import 'package:flutter/material.dart';
import 'package:valorant_strategies_flutter/Pages/GridViewMaps.dart';
import 'package:valorant_strategies_flutter/Pages/Homepage.dart';
import 'package:valorant_strategies_flutter/Pages/StratagiesPage.dart';

class Mainpage extends StatefulWidget {
  Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Stratagiespage(),
    Homepage(),
    Gridviewmaps(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index; // Update index on tap
                });
              },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'H O M E'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_4), label: 'A G E N T S'),
          BottomNavigationBarItem(
              icon: Icon(Icons.map_sharp), label: 'M A P S'),
        ],
      ),
    );
  }
}
