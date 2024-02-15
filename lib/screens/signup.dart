import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LoginButton(
            onTap: () {
              
            },
            child: const Text(
              "Signup",
              style: TextStyle(
                fontFamily: "Monospace",
              ),  
            )
          ),
        ],
      ),
    );
  }
}