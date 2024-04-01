import 'package:binbuddy_frontend/net/errors.dart';
import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/screens/widgets/alert.dart';
import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:binbuddy_frontend/screens/widgets/login_container.dart';
import 'package:binbuddy_frontend/screens/widgets/login_textbox.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
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
      if(_nameController.value.text.isEmpty || _emailController.value.text.isEmpty || _passwordController.value.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => const InformationDialog(
            title: "An error has occured.",
            message: "Please fill in all fields.",
          ),
        );
        
        return;
      }
      
      User user = User.attempt(_nameController.text, _emailController.text, _passwordController.text);
      
      try {
        user = await RequestSender.trySignUp(user);

        widget.setUser(user);
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) => InformationDialog(
            title: "Error",
            message: Errors.convertAuthError(e),
          ),
        );
        
        _passwordController.clear();
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => InformationDialog(
            title: "Error",
            message: e.toString(),
          ),
        );

        _passwordController.clear();

      } 
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