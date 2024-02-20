import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/screens/widgets/login_container.dart';
import 'package:binbuddy_frontend/screens/widgets/login_textbox.dart';
import 'package:flutter/material.dart';
import 'widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.setUser});

  final Function setUser;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
      User user = await RequestSender.tryLogin(_emailController.text, _passwordController.text);
      widget.setUser(user);
  }

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
                  controller: _emailController,
                ),
                LoginTextBox(
                  hintText: "Password",
                  fontFamily: "Monospace",
                  obscureText: true,
                  controller: _passwordController,
                ),
                LoginButton(
                  onTap: login,
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