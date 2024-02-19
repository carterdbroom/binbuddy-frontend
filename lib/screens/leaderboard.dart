import 'package:binbuddy_frontend/screens/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/net/request_sender.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}


class _LeaderboardState extends State<Leaderboard> {

  List<User> _leaderboard = [];
  bool isLoading = false;
  List<String> test = ["Bob", "Tim", "Joe", "Timmy", "John","Bob", "Tim", "Joe", "Timmy", "John","Bob", "Tim", "Joe", "Timmy", "John"]; 
  @override
  void initState() {
    initFunction();
    super.initState();
  }

  void initFunction() async {
    setState(() {
      isLoading = true;
    });
    
    _leaderboard = await RequestSender.tryGetLeaderboard();
    
    setState(() {
      isLoading = false;
    });
  }

  void updateLeaderboard() async {
    setState(() {
      isLoading = true;
    });

    _leaderboard = await RequestSender.tryGetLeaderboard();

    setState(() {
      isLoading = false;
    });
  }

  String plusOne(int i) {
    i += 1;
    return i.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Leaderboard",
          style: TextStyle(
            fontFamily: "Monospace",
          ),
        ),
      ),
      body: ListView.builder (
        itemCount: test.length,
        prototypeItem: ListTile(
          title: Text(test.first),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(plusOne(index)),
            title: Text(test[index]),
            trailing: Text("30"),
          );
        },
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}


/*
body: ListView.builder (
        itemCount: _leaderboard.length,
        prototypeItem: ListTile(
          title: Text(_leaderboard.first.name!),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text("$index"),
            title: Text(_leaderboard[index].name!),
            trailing: Text("$_leaderboard[index].score!")
          );
        },
      ),
*/