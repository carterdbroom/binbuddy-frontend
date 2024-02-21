import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/screens/home.dart';
import 'package:binbuddy_frontend/screens/login.dart';
import 'package:binbuddy_frontend/screens/signup.dart';
import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key, required this.setUser, required this.user});

  final Function setUser;
  final User? user;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: ((context) => HomePage(user: user, setUser: setUser)))
        );
    }
    
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => LoginPage(setUser: setUser)))
                  );
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupPage(setUser: setUser)));
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