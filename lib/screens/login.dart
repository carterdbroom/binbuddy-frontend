import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/screens/widgets/login_container.dart';
import 'package:binbuddy_frontend/screens/widgets/login_textbox.dart';
import 'package:flutter/material.dart';
import 'widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

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
                LoginTextBox(
                  hintText: "Email", 
                  fontFamily: "Monospace",
                  obscureText: false,
                  controller: emailController,
                ),
                LoginTextBox(
                  hintText: "Password",
                  fontFamily: "Monospace",
                  obscureText: true,
                  controller: passwordController,
                ),
                LoginButton(
                  onTap: () {
                    RequestSender.tryLogin(emailController.text, passwordController.text);
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