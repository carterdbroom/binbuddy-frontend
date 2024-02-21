import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:binbuddy_frontend/screens/widgets/login_container.dart';
import 'package:binbuddy_frontend/screens/widgets/login_textbox.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key, required this.setUser});

  final Function setUser;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signup() async {
      User user = User.attempt(_nameController.text, _emailController.text, _passwordController.text);
      user = await RequestSender.trySignUp(user);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginContainer(
            children: [ 
              LoginTextBox(
                hintText: "Name",
                fontFamily: "Monospace",
                controller: _nameController,
                obscureText: false,
              ),
              LoginTextBox(
                hintText: "Email",
                fontFamily: "Monospace",
                controller: _emailController,
                obscureText: false,
              ),
              LoginTextBox(
                hintText: "Password",
                fontFamily: "Monospace",
                controller: _passwordController,
                obscureText: true,
              ),
              LoginButton(
                onTap: signup,
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