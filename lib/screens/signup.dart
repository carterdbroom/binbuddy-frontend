import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:binbuddy_frontend/screens/widgets/login_container.dart';
import 'package:binbuddy_frontend/screens/widgets/login_textbox.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BinBuddy",
          style: TextStyle(
            fontFamily: "Monospace",
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginContainer(
            children: [ 
              const LoginTextBox(
                hintText: "Name",
                fontFamily: "Monospace",
                obscureText: false,
              ),
              const LoginTextBox(
                hintText: "Email",
                fontFamily: "Monospace",
                obscureText: false,
              ),
              const LoginTextBox(
                hintText: "Password",
                fontFamily: "Monospace",
                obscureText: true,
              ),
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
        ],
      ),
    );
  }
}