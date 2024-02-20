import 'package:binbuddy_frontend/screens/widgets/bottom_nav_bar.dart';
import 'package:binbuddy_frontend/screens/leaderboard.dart';
import 'package:binbuddy_frontend/screens/waste_wizard.dart';
import 'package:segment_bar/percent_graph_model.dart';
import 'package:segment_bar/segment_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({
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

    if(total == 0) {
        return 100;
    }

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
            const Expanded(
              child: Center(
                child: Text(
                  "My Waste Habits",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Monospace",
                    fontWeight: FontWeight.bold,
                  ),
                ),  
              ),
            ),
            Expanded(
              child: Row(
                children: [  
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.delete_outline_rounded, size: 100,),
                        const Text(
                          "Garbage",
                          style: TextStyle(
                            fontFamily: "Monospace",
                          ),
                        ),
                        Text(
                          "Items: $garbageValue",
                          style: const TextStyle(
                            fontFamily: "Monospace",
                          )
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.compost, size: 100),
                        const Text(
                          "Compost",
                          style: TextStyle(
                            fontFamily: "Monospace",
                          ),
                        ),
                        Text(
                          "Items: $compostValue",
                          style: const TextStyle(
                            fontFamily: "Monospace",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.recycling_rounded, size: 100),
                        const Text(
                          "Recycling",
                          style: TextStyle(
                            fontFamily: "Monospace",
                          ),
                        ),
                        Text(
                          "Items: $recyclingValue",
                          style: const TextStyle(
                            fontFamily: "Monospace",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 20.0),
                  child: SegmentBar(
                    segmentData: [
                      SegmentBarModel(value: _getPercentage(garbageValue, compostValue, recyclingValue), color: Colors.black),
                      SegmentBarModel(value: _getPercentage(compostValue, garbageValue, recyclingValue), color: Colors.green),
                      SegmentBarModel(value: _getPercentage(recyclingValue, compostValue, garbageValue), color: Colors.blue),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Bottom(),
    );
  }
}