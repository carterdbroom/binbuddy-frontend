import 'package:binbuddy_frontend/screens/widgets/login_container.dart';
import 'package:binbuddy_frontend/screens/widgets/login_textbox.dart';
import 'package:flutter/material.dart';
import 'widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
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
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginContainer(
              children: [
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
                    "Login",
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