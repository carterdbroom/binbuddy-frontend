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
      body: Column(
        children: [
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
    );
  }
}