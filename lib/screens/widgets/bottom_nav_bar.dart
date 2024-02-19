import 'package:binbuddy_frontend/screens/home.dart';
import 'package:binbuddy_frontend/screens/leaderboard.dart';
import 'package:binbuddy_frontend/screens/waste_wizard.dart';
import 'package:flutter/material.dart';


class Bottom extends StatefulWidget {
  const Bottom({super.key});


  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: "Waste Wizard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard_rounded),
          label: "Leaderboard",
        ),
      ],
      onTap: (index) => setState (() => _selectedIndex = index),

    );
  }
}