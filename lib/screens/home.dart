import 'package:segment_bar/percent_graph_model.dart';
import 'package:segment_bar/segment_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.garbageValue,
    required this.compostValue,
    required this.recyclingValue,
    super.key}
    );

  final int  garbageValue;
  final int compostValue;
  final int recyclingValue;

  // Returns the percentage of the first integer argument
  double _getPercentage(int g, int c, int r){
    int total = g + c + r;
    return g/total*100;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "BinBuddy",
          style: TextStyle(
            fontFamily: "Monospace",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "My Waste Habits",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Monospace",
                ),
              ),  
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SegmentBar(
                  segmentData: [
                    SegmentBarModel(value: _getPercentage(10, 20, 30), color: Colors.black, label: "Garbage"),
                    SegmentBarModel(value: _getPercentage(20, 10, 30), color: Colors.green, label: "Compost"),
                    SegmentBarModel(value: _getPercentage(30, 20, 10), color: Colors.blue, label: "Recycling"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}