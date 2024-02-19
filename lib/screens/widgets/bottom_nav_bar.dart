import 'package:binbuddy_frontend/screens/home.dart';
import 'package:binbuddy_frontend/screens/leaderboard.dart';
import 'package:binbuddy_frontend/screens/waste_wizard.dart';
import 'package:flutter/material.dart';

int _selectedIndex = 0;

class Bottom extends StatefulWidget {
  const Bottom({super.key});


  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedLabelStyle: const TextStyle(
        fontFamily: "Monospace"
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: "Monospace"
      ),
      selectedItemColor: const Color.fromARGB(255, 0, 37, 0),
      unselectedItemColor: Colors.white,
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
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        if (_selectedIndex == 0) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage(garbageValue: 0, compostValue: 0, recyclingValue: 0)),
          );
        }
        else if (_selectedIndex == 1) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WasteWizardPage()),
          );
        }
        else if (_selectedIndex == 2) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Leaderboard()),
          );
        }
      },

    );
  }
}