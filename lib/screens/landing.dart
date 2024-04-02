import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key, required this.setUser, required this.user});

  final Function setUser;
  final User? user;

  @override
  Widget build(BuildContext context) {
    //print(user == null);
    Future.delayed(Duration.zero, () {
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }  
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "BinBuddy",
            style: TextStyle(
              fontSize: 50.0,
              fontFamily: "Monospace"
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginButton(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "Monospace",
                  )       
                )
              ),
              LoginButton(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },  
                child: const Text(
                  "Signup",
                  style: TextStyle(
                    fontFamily: "Monospace",
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}