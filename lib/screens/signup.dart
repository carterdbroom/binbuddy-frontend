import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:binbuddy_frontend/screens/widgets/login_container.dart';
import 'package:binbuddy_frontend/screens/widgets/login_textbox.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final nameController = TextEditingController();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginContainer(
            children: [ 
              LoginTextBox(
                hintText: "Name",
                fontFamily: "Monospace",
                controller: nameController,
                obscureText: false,
              ),
              LoginTextBox(
                hintText: "Email",
                fontFamily: "Monospace",
                controller: emailController,
                obscureText: false,
              ),
              LoginTextBox(
                hintText: "Password",
                fontFamily: "Monospace",
                controller: passwordController,
                obscureText: true,
              ),
              LoginButton(
                onTap: () {
                  User user = User.attempt(nameController.text, emailController.text, passwordController.text);
                  RequestSender.trySignUp(user);
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