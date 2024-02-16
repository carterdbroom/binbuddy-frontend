import 'package:binbuddy_frontend/screens/login.dart';
import 'package:binbuddy_frontend/screens/signup.dart';
import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    MaterialPageRoute(builder: ((context) => const LoginPage()))
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
                    MaterialPageRoute(builder: (context) => const SignupPage()));
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